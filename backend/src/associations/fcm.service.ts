import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as admin from 'firebase-admin';

@Injectable()
export class FcmService {
  private readonly logger = new Logger(FcmService.name);
  private readonly enabled: boolean;

  constructor(config: ConfigService) {
    const serviceAccountJson = config.get<string>('FIREBASE_SERVICE_ACCOUNT_JSON');
    const projectId = config.get<string>('FIREBASE_PROJECT_ID');
    const clientEmail = config.get<string>('FIREBASE_CLIENT_EMAIL');
    const privateKey = config
      .get<string>('FIREBASE_PRIVATE_KEY')
      ?.replace(/\\n/g, '\n');

    if (!admin.apps.length && serviceAccountJson) {
      admin.initializeApp({
        credential: admin.credential.cert(JSON.parse(serviceAccountJson)),
      });
    } else if (!admin.apps.length && projectId && clientEmail && privateKey) {
      admin.initializeApp({
        credential: admin.credential.cert({
          projectId,
          clientEmail,
          privateKey,
        }),
      });
    }

    this.enabled = admin.apps.length > 0;
    if (!this.enabled) {
      this.logger.warn('FCM disabled. Configure Firebase service account env vars to send push notifications.');
    }
  }

  async sendAssociationNotification(params: {
    tokens: string[];
    title: string;
    body: string;
    severity: string;
    associationName: string;
    notificationId: string;
    actionUrl?: string;
  }) {
    const uniqueTokens = [...new Set(params.tokens)].filter(Boolean);
    if (!this.enabled || uniqueTokens.length === 0) {
      return { successCount: 0, failureCount: 0, skipped: true };
    }

    const response = await admin.messaging().sendEachForMulticast({
      tokens: uniqueTokens,
      notification: {
        title: params.title,
        body: params.body,
      },
      data: {
        type: 'ASSOCIATION_ALERT',
        severity: params.severity,
        associationName: params.associationName,
        notificationId: params.notificationId,
        actionUrl: params.actionUrl ?? '',
      },
      android: {
        priority: 'high',
        notification: {
          channelId: 'association_alerts',
          icon: 'ic_notification',
          color: '#FD8B00',
        },
      },
      apns: {
        payload: {
          aps: {
            sound: 'default',
            badge: 1,
          },
        },
      },
      webpush: {
        notification: {
          icon: '/icons/Icon-192.png',
          badge: '/icons/Icon-192.png',
          tag: params.notificationId,
        },
      },
    });

    return {
      successCount: response.successCount,
      failureCount: response.failureCount,
      skipped: false,
    };
  }
}
