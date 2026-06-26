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
exports.PublishAssociationNotificationDto = void 0;
const swagger_1 = require("@nestjs/swagger");
const class_validator_1 = require("class-validator");
const client_1 = require("@prisma/client");
class PublishAssociationNotificationDto {
    title;
    body;
    severity;
    actionLabel;
    actionUrl;
    targetStates;
    targetTypes;
}
exports.PublishAssociationNotificationDto = PublishAssociationNotificationDto;
__decorate([
    (0, swagger_1.ApiProperty)(),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.MinLength)(3),
    (0, class_validator_1.MaxLength)(90),
    __metadata("design:type", String)
], PublishAssociationNotificationDto.prototype, "title", void 0);
__decorate([
    (0, swagger_1.ApiProperty)(),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.MinLength)(8),
    (0, class_validator_1.MaxLength)(700),
    __metadata("design:type", String)
], PublishAssociationNotificationDto.prototype, "body", void 0);
__decorate([
    (0, swagger_1.ApiProperty)({ enum: client_1.AssociationNotificationSeverity }),
    (0, class_validator_1.IsEnum)(client_1.AssociationNotificationSeverity),
    __metadata("design:type", String)
], PublishAssociationNotificationDto.prototype, "severity", void 0);
__decorate([
    (0, swagger_1.ApiPropertyOptional)(),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsString)(),
    (0, class_validator_1.MaxLength)(32),
    __metadata("design:type", String)
], PublishAssociationNotificationDto.prototype, "actionLabel", void 0);
__decorate([
    (0, swagger_1.ApiPropertyOptional)(),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsUrl)({ require_tld: false }),
    __metadata("design:type", String)
], PublishAssociationNotificationDto.prototype, "actionUrl", void 0);
__decorate([
    (0, swagger_1.ApiPropertyOptional)({ type: [String] }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsArray)(),
    (0, class_validator_1.ArrayMaxSize)(36),
    (0, class_validator_1.IsString)({ each: true }),
    __metadata("design:type", Array)
], PublishAssociationNotificationDto.prototype, "targetStates", void 0);
__decorate([
    (0, swagger_1.ApiPropertyOptional)({ enum: client_1.BusinessType, isArray: true }),
    (0, class_validator_1.IsOptional)(),
    (0, class_validator_1.IsArray)(),
    (0, class_validator_1.ArrayMaxSize)(20),
    (0, class_validator_1.IsEnum)(client_1.BusinessType, { each: true }),
    __metadata("design:type", Array)
], PublishAssociationNotificationDto.prototype, "targetTypes", void 0);
//# sourceMappingURL=publish-association-notification.dto.js.map