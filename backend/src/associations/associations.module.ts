import { Module } from '@nestjs/common';

import { PrismaModule } from '../prisma/prisma.module';
import { AssociationsController } from './associations.controller';
import { AssociationsService } from './associations.service';
import { FcmService } from './fcm.service';

@Module({
  imports: [PrismaModule],
  controllers: [AssociationsController],
  providers: [AssociationsService, FcmService],
})
export class AssociationsModule {}
