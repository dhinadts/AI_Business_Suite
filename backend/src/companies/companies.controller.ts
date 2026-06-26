import { Body, Controller, Get, Patch, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

import { CurrentUser } from '../auth/current-user.decorator';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { CompaniesService } from './companies.service';
import { UpdateCompanyDto } from './dto/update-company.dto';

@ApiTags('companies')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('companies')
export class CompaniesController {
  constructor(private readonly companiesService: CompaniesService) {}

  @Get('me')
  getMine(@CurrentUser() user: { companyId: string }) {
    return this.companiesService.getMine(user.companyId);
  }

  @Patch('me')
  updateMine(@CurrentUser() user: { companyId: string }, @Body() dto: UpdateCompanyDto) {
    return this.companiesService.updateMine(user.companyId, dto);
  }
}
