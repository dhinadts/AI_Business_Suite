import { Module } from '@nestjs/common';

import { CompaniesController } from './companies.controller';
import { CompanyClassifierService } from './company-classifier.service';
import { CompaniesService } from './companies.service';

@Module({
  controllers: [CompaniesController],
  providers: [CompaniesService, CompanyClassifierService],
  exports: [CompanyClassifierService],
})
export class CompaniesModule {}
