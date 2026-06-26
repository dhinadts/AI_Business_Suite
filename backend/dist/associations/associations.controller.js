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
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AssociationsController = void 0;
const common_1 = require("@nestjs/common");
const swagger_1 = require("@nestjs/swagger");
const current_user_decorator_1 = require("../auth/current-user.decorator");
const jwt_auth_guard_1 = require("../auth/jwt-auth.guard");
const associations_service_1 = require("./associations.service");
const publish_association_notification_dto_1 = require("./dto/publish-association-notification.dto");
const register_device_token_dto_1 = require("./dto/register-device-token.dto");
let AssociationsController = class AssociationsController {
    associationsService;
    constructor(associationsService) {
        this.associationsService = associationsService;
    }
    myAssociations(user) {
        return this.associationsService.myAssociations(user.companyId);
    }
    notifications(user) {
        return this.associationsService.notifications(user.companyId);
    }
    registerDeviceToken(user, dto) {
        return this.associationsService.registerDeviceToken(user.sub, user.companyId, dto);
    }
    publish(user, associationId, dto) {
        return this.associationsService.publish(associationId, user.sub, user.companyId, dto);
    }
    publishAlias(user, associationId, dto) {
        return this.associationsService.publish(associationId, user.sub, user.companyId, dto);
    }
};
exports.AssociationsController = AssociationsController;
__decorate([
    (0, common_1.Get)('me'),
    __param(0, (0, current_user_decorator_1.CurrentUser)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], AssociationsController.prototype, "myAssociations", null);
__decorate([
    (0, common_1.Get)('notifications'),
    __param(0, (0, current_user_decorator_1.CurrentUser)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object]),
    __metadata("design:returntype", void 0)
], AssociationsController.prototype, "notifications", null);
__decorate([
    (0, common_1.Post)('device-token'),
    __param(0, (0, current_user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, register_device_token_dto_1.RegisterDeviceTokenDto]),
    __metadata("design:returntype", void 0)
], AssociationsController.prototype, "registerDeviceToken", null);
__decorate([
    (0, common_1.Post)(':associationId/notifications'),
    __param(0, (0, current_user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Param)('associationId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, publish_association_notification_dto_1.PublishAssociationNotificationDto]),
    __metadata("design:returntype", void 0)
], AssociationsController.prototype, "publish", null);
__decorate([
    (0, common_1.Patch)(':associationId/notifications'),
    __param(0, (0, current_user_decorator_1.CurrentUser)()),
    __param(1, (0, common_1.Param)('associationId')),
    __param(2, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [Object, String, publish_association_notification_dto_1.PublishAssociationNotificationDto]),
    __metadata("design:returntype", void 0)
], AssociationsController.prototype, "publishAlias", null);
exports.AssociationsController = AssociationsController = __decorate([
    (0, swagger_1.ApiTags)('associations'),
    (0, swagger_1.ApiBearerAuth)(),
    (0, common_1.UseGuards)(jwt_auth_guard_1.JwtAuthGuard),
    (0, common_1.Controller)('associations'),
    __metadata("design:paramtypes", [associations_service_1.AssociationsService])
], AssociationsController);
//# sourceMappingURL=associations.controller.js.map