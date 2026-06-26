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
exports.HealthController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const prisma_service_1 = require("../prisma/prisma.service");
let HealthController = class HealthController {
    prisma;
    constructor(prisma) {
        this.prisma = prisma;
    }
    health() {
        return {
            ok: true,
            service: 'AI Business Suite API',
            timestamp: new Date().toISOString(),
        };
    }
    async database() {
        const rawUrl = process.env.DATABASE_URL;
        const normalizedUrl = (0, prisma_service_1.normalizeMongoUrl)(rawUrl);
        const hasDatabaseUrl = Boolean(rawUrl?.trim());
        const hasDatabaseName = Boolean(normalizedUrl &&
            normalizedUrl
                .split('?', 2)[0]
                .substring(normalizedUrl.split('?', 2)[0].lastIndexOf('/') + 1)
                .trim());
        try {
            await this.prisma.user.count();
            return {
                ok: true,
                database: 'connected',
                hasDatabaseUrl,
                hasDatabaseName,
            };
        }
        catch (error) {
            return {
                ok: false,
                database: 'failed',
                hasDatabaseUrl,
                hasDatabaseName,
                error: error instanceof Error ? error.message : 'Unknown database error',
            };
        }
    }
};
exports.HealthController = HealthController;
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", void 0)
], HealthController.prototype, "health", null);
__decorate([
    (0, common_1.Get)('db'),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], HealthController.prototype, "database", null);
exports.HealthController = HealthController = __decorate([
    (0, swagger_1.ApiTags)('health'),
    (0, common_1.Controller)('health'),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService])
], HealthController);
