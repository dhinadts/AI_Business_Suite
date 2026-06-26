import { AssociationsService } from './associations.service';
import { PublishAssociationNotificationDto } from './dto/publish-association-notification.dto';
import { RegisterDeviceTokenDto } from './dto/register-device-token.dto';
type SessionUser = {
    sub: string;
    companyId: string;
};
export declare class AssociationsController {
    private readonly associationsService;
    constructor(associationsService: AssociationsService);
    myAssociations(user: SessionUser): Promise<{
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
    notifications(user: SessionUser): Promise<{
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
    registerDeviceToken(user: SessionUser, dto: RegisterDeviceTokenDto): Promise<{
        id: string;
        platform: import(".prisma/client").$Enums.DevicePlatform;
        active: boolean;
    }>;
    publish(user: SessionUser, associationId: string, dto: PublishAssociationNotificationDto): Promise<{
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
    publishAlias(user: SessionUser, associationId: string, dto: PublishAssociationNotificationDto): Promise<{
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
export {};
