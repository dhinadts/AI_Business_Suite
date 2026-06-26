import { AssociationNotificationSeverity, BusinessType } from '@prisma/client';
export declare class PublishAssociationNotificationDto {
    title: string;
    body: string;
    severity: AssociationNotificationSeverity;
    actionLabel?: string;
    actionUrl?: string;
    targetStates?: string[];
    targetTypes?: BusinessType[];
}
