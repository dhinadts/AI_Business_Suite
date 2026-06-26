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
exports.AuthService = void 0;
const common_1 = require("@nestjs/common");
const jwt_1 = require("@nestjs/jwt");
const client_1 = require("@prisma/client");
const bcrypt = require("bcrypt");
const company_classifier_service_1 = require("../companies/company-classifier.service");
const prisma_service_1 = require("../prisma/prisma.service");
let AuthService = class AuthService {
    prisma;
    jwtService;
    classifier;
    constructor(prisma, jwtService, classifier) {
        this.prisma = prisma;
        this.jwtService = jwtService;
        this.classifier = classifier;
    }
    async signup(dto) {
        const existing = await this.prisma.user.findUnique({ where: { email: dto.email.toLowerCase() } });
        if (existing)
            throw new common_1.ConflictException('Email is already registered');
        const classified = this.classifier.classify(dto.company);
        const passwordHash = await bcrypt.hash(dto.password, 12);
        const company = await this.prisma.company.create({
            data: {
                ...dto.company,
                ...classified,
            },
        });
        const user = await this.prisma.user.create({
            data: {
                fullName: dto.fullName,
                email: dto.email.toLowerCase(),
                phone: dto.phone,
                passwordHash,
                role: client_1.UserRole.OWNER,
                companyId: company.id,
            },
        });
        return this.authResponse(user.id, company.id);
    }
    async login(dto) {
        const user = await this.prisma.user.findUnique({
            where: { email: dto.email.toLowerCase() },
        });
        if (!user)
            throw new common_1.UnauthorizedException('Invalid email or password');
        const valid = await bcrypt.compare(dto.password, user.passwordHash);
        if (!valid)
            throw new common_1.UnauthorizedException('Invalid email or password');
        return this.authResponse(user.id, user.companyId);
    }
    async me(userId) {
        const user = await this.prisma.user.findUniqueOrThrow({
            where: { id: userId },
            include: { company: true },
        });
        return this.formatAuthPayload(user, user.company);
    }
    async authResponse(userId, companyId) {
        const user = await this.prisma.user.findUniqueOrThrow({ where: { id: userId } });
        const company = await this.prisma.company.findUniqueOrThrow({ where: { id: companyId } });
        const accessToken = await this.jwtService.signAsync({
            sub: user.id,
            email: user.email,
            companyId: company.id,
            role: user.role,
        });
        return {
            accessToken,
            ...this.formatAuthPayload(user, company),
        };
    }
    formatAuthPayload(user, company) {
        const { passwordHash, ...safeUser } = user;
        return {
            user: safeUser,
            company,
            uiConfig: this.classifier.getUiConfig(company.classification),
        };
    }
};
exports.AuthService = AuthService;
exports.AuthService = AuthService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [prisma_service_1.PrismaService,
        jwt_1.JwtService,
        company_classifier_service_1.CompanyClassifierService])
], AuthService);
//# sourceMappingURL=auth.service.js.map