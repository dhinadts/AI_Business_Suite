import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

import { CurrentUser } from '../auth/current-user.decorator';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { AssociationsService } from './associations.service';
import { PublishAssociationNotificationDto } from './dto/publish-association-notification.dto';
import { RegisterDeviceTokenDto } from './dto/register-device-token.dto';

type SessionUser = {
  sub: string;
  companyId: string;
};

@ApiTags('associations')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('associations')
export class AssociationsController {
  constructor(private readonly associationsService: AssociationsService) {}

  @Get('me')
  myAssociations(@CurrentUser() user: SessionUser) {
    return this.associationsService.myAssociations(user.companyId);
  }

  @Get('notifications')
  notifications(@CurrentUser() user: SessionUser) {
    return this.associationsService.notifications(user.companyId);
  }

  @Post('device-token')
  registerDeviceToken(
    @CurrentUser() user: SessionUser,
    @Body() dto: RegisterDeviceTokenDto,
  ) {
    return this.associationsService.registerDeviceToken(
      user.sub,
      user.companyId,
      dto,
    );
  }

  @Post(':associationId/notifications')
  publish(
    @CurrentUser() user: SessionUser,
    @Param('associationId') associationId: string,
    @Body() dto: PublishAssociationNotificationDto,
  ) {
    return this.associationsService.publish(
      associationId,
      user.sub,
      user.companyId,
      dto,
    );
  }

  @Patch(':associationId/notifications')
  publishAlias(
    @CurrentUser() user: SessionUser,
    @Param('associationId') associationId: string,
    @Body() dto: PublishAssociationNotificationDto,
  ) {
    return this.associationsService.publish(
      associationId,
      user.sub,
      user.companyId,
      dto,
    );
  }
}
