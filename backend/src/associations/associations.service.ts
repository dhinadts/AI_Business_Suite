import {
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { AssociationRole, Prisma } from '@prisma/client';

import { PrismaService } from '../prisma/prisma.service';
import { PublishAssociationNotificationDto } from './dto/publish-association-notification.dto';
import { RegisterDeviceTokenDto } from './dto/register-device-token.dto';
import { FcmService } from './fcm.service';

const publisherRoles = new Set<AssociationRole>([
  AssociationRole.HEAD,
  AssociationRole.SUB_HEAD,
  AssociationRole.FINANCIAL_SECRETARY,
  AssociationRole.TREASURER,
]);

@Injectable()
export class AssociationsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly fcm: FcmService,
  ) {}

  async myAssociations(companyId: string) {
    const memberships = await this.prisma.associationMembership.findMany({
      where: { companyId, active: true },
      include: {
        association: true,
      },
      orderBy: { createdAt: 'desc' },
    });

    return {
      associations: memberships.map((membership) => ({
        id: membership.association.id,
        name: membership.association.name,
        industry: membership.association.industry,
        state: membership.association.state,
        district: membership.association.district,
        description: membership.association.description,
        role: membership.role,
        canPublish: publisherRoles.has(membership.role),
      })),
    };
  }

  async notifications(companyId: string) {
    const memberships = await this.prisma.associationMembership.findMany({
      where: { companyId, active: true },
      select: { associationId: true },
    });

    const associationIds = memberships.map((item) => item.associationId);
    const notificationWhere: Prisma.AssociationNotificationWhereInput = {
      OR: [{ companyId }],
    };
    if (associationIds.length) {
      notificationWhere.OR?.push({ associationId: { in: associationIds } });
    }

    const notifications = await this.prisma.associationNotification.findMany({
      where: {
        ...notificationWhere,
      },
      include: { association: true },
      orderBy: { createdAt: 'desc' },
      take: 50,
    });

    return {
      notifications: notifications.map((item) => ({
        id: item.id,
        associationId: item.associationId,
        associationName: item.association.name,
        title: item.title,
        body: item.body,
        severity: item.severity,
        actionLabel: item.actionLabel,
        actionUrl: item.actionUrl,
        sentByRole: item.sentByRole,
        targetStates: item.targetStates,
        targetTypes: item.targetTypes,
        sentCount: item.sentCount,
        createdAt: item.createdAt,
      })),
    };
  }

  async registerDeviceToken(
    userId: string,
    companyId: string,
    dto: RegisterDeviceTokenDto,
  ) {
    const token = await this.prisma.deviceToken.upsert({
      where: { token: dto.token },
      update: {
        userId,
        companyId,
        platform: dto.platform,
        active: true,
      },
      create: {
        token: dto.token,
        platform: dto.platform,
        userId,
        companyId,
      },
    });

    return {
      id: token.id,
      platform: token.platform,
      active: token.active,
    };
  }

  async publish(
    associationId: string,
    userId: string,
    companyId: string,
    dto: PublishAssociationNotificationDto,
  ) {
    const membership = await this.prisma.associationMembership.findFirst({
      where: {
        associationId,
        companyId,
        userId,
        active: true,
      },
      include: { association: true },
    });

    if (!membership) {
      throw new NotFoundException('Association membership not found.');
    }
    if (!publisherRoles.has(membership.role)) {
      throw new ForbiddenException(
        'Only association head, sub head, financial secretary, or treasurer can publish notifications.',
      );
    }

    const memberWhere: Prisma.AssociationMembershipWhereInput = {
      associationId,
      active: true,
      company: {
        ...(dto.targetStates?.length
          ? { state: { in: dto.targetStates } }
          : {}),
        ...(dto.targetTypes?.length
          ? { businessType: { in: dto.targetTypes } }
          : {}),
      },
    };

    const recipients = await this.prisma.associationMembership.findMany({
      where: memberWhere,
      select: { companyId: true },
    });
    const recipientCompanyIds = [...new Set(recipients.map((item) => item.companyId))];

    const notification = await this.prisma.associationNotification.create({
      data: {
        associationId,
        title: dto.title,
        body: dto.body,
        severity: dto.severity,
        actionLabel: dto.actionLabel,
        actionUrl: dto.actionUrl,
        sentByUserId: userId,
        sentByRole: membership.role,
        targetStates: dto.targetStates ?? [],
        targetTypes: dto.targetTypes ?? [],
        sentCount: recipientCompanyIds.length,
      },
    });

    const tokens = await this.prisma.deviceToken.findMany({
      where: {
        active: true,
        companyId: { in: recipientCompanyIds },
      },
      select: { token: true },
    });

    const push = await this.fcm.sendAssociationNotification({
      tokens: tokens.map((item) => item.token),
      title: dto.title,
      body: dto.body,
      severity: dto.severity,
      associationName: membership.association.name,
      notificationId: notification.id,
      actionUrl: dto.actionUrl,
    });

    return {
      notification,
      recipientCompanies: recipientCompanyIds.length,
      push,
    };
  }
}
