import { ConfigService } from '@nestjs/config';
export declare class FcmService {
    private readonly logger;
    private readonly enabled;
    constructor(config: ConfigService);
    sendAssociationNotification(params: {
        tokens: string[];
        title: string;
        body: string;
        severity: string;
        associationName: string;
        notificationId: string;
        actionUrl?: string;
    }): Promise<{
        successCount: number;
        failureCount: number;
        skipped: boolean;
    }>;
}
