import { PrismaService } from '../prisma/prisma.service';
import { PublishAssociationNotificationDto } from './dto/publish-association-notification.dto';
import { RegisterDeviceTokenDto } from './dto/register-device-token.dto';
import { FcmService } from './fcm.service';
export declare class AssociationsService {
    private readonly prisma;
    private readonly fcm;
    constructor(prisma: PrismaService, fcm: FcmService);
    myAssociations(companyId: string): Promise<{
        associations: {
            id: string;
            name: string;
            industry: string;
            state: string | null;
            district: string | null;
            description: string | null;
            role: import(".prisma/client").$Enums.AssociationRole;
            canPublish: boolean;
        }[];
    }>;
    notifications(companyId: string): Promise<{
        notifications: {
            id: string;
            associationId: string;
            associationName: string;
            title: string;
            body: string;
            severity: import(".prisma/client").$Enums.AssociationNotificationSeverity;
            actionLabel: string | null;
            actionUrl: string | null;
            sentByRole: import(".prisma/client").$Enums.AssociationRole;
            targetStates: string[];
            targetTypes: import(".prisma/client").$Enums.BusinessType[];
            sentCount: number;
            createdAt: Date;
        }[];
    }>;
    registerDeviceToken(userId: string, companyId: string, dto: RegisterDeviceTokenDto): Promise<{
        id: string;
        platform: import(".prisma/client").$Enums.DevicePlatform;
        active: boolean;
    }>;
    publish(associationId: string, userId: string, companyId: string, dto: PublishAssociationNotificationDto): Promise<{
        notification: {
            id: string;
            associationId: string;
            companyId: string | null;
            createdAt: Date;
            title: string;
            body: string;
            severity: import(".prisma/client").$Enums.AssociationNotificationSeverity;
            actionLabel: string | null;
            actionUrl: string | null;
            sentByUserId: string;
            sentByRole: import(".prisma/client").$Enums.AssociationRole;
            targetStates: string[];
            targetTypes: import(".prisma/client").$Enums.BusinessType[];
            sentCount: number;
        };
        recipientCompanies: number;
        push: {
            successCount: number;
            failureCount: number;
            skipped: boolean;
        };
    }>;
}
