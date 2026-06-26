"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var FcmService_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.FcmService = void 0;
const common_1 = require("@nestjs/common");
const config_1 = require("@nestjs/config");
const admin = __importStar(require("firebase-admin"));
let FcmService = FcmService_1 = class FcmService {
    logger = new common_1.Logger(FcmService_1.name);
    enabled;
    constructor(config) {
        const serviceAccountJson = config.get('FIREBASE_SERVICE_ACCOUNT_JSON');
        const projectId = config.get('FIREBASE_PROJECT_ID');
        const clientEmail = config.get('FIREBASE_CLIENT_EMAIL');
        const privateKey = config
            .get('FIREBASE_PRIVATE_KEY')
            ?.replace(/\\n/g, '\n');
        if (!admin.apps.length && serviceAccountJson) {
            admin.initializeApp({
                credential: admin.credential.cert(JSON.parse(serviceAccountJson)),
            });
        }
        else if (!admin.apps.length && projectId && clientEmail && privateKey) {
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
    async sendAssociationNotification(params) {
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
};
exports.FcmService = FcmService;
exports.FcmService = FcmService = FcmService_1 = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [config_1.ConfigService])
], FcmService);
