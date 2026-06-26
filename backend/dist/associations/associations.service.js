"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AssociationsService = void 0;
const common_1 = require("@nestjs/common");
const client_1 = require("@prisma/client");
const prisma_service_1 = require("../prisma/prisma.service");
const fcm_service_1 = require("./fcm.service");
const publisherRoles = new Set([
    client_1.AssociationRole.HEAD,
    client_1.AssociationRole.SUB_HEAD,
    client_1.AssociationRole.FINANCIAL_SECRETARY,
    client_1.AssociationRole.TREASURER,
]);
let AssociationsService = class AssociationsService {
    prisma;
    fcm;
    constructor(prisma, fcm) {
        this.prisma = prisma;
        this.fcm = fcm;
    }
    async myAssociations(companyId) {
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
    async notifications(companyId) {
        const memberships = await this.prisma.associationMembership.findMany({
            where: { companyId, active: true },
            select: { associationId: true },
        });
        const associationIds = memberships.map((item) => item.associationId);
        const notificationWhere = {
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
    async registerDeviceToken(userId, companyId, dto) {
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
    async publish(associationId, userId, companyId, dto) {
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
            throw new common_1.NotFoundException('Association membership not found.');
        }
        if (!publisherRoles.has(membership.role)) {
            throw new common_1.ForbiddenException('Only association head, sub head, financial secretary, or treasurer can publish notifications.');
        }
        const memberWhere = {
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
};
exports.AssociationsService = AssociationsService;
exports.AssociationsService = AssociationsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        fcm_service_1.FcmService])
], AssociationsService);
//# sourceMappingURL=associations.service.js.map