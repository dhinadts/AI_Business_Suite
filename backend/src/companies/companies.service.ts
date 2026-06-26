import { Injectable, NotFoundException } from '@nestjs/common';

import { PrismaService } from '../prisma/prisma.service';
import { CompanyClassifierService } from './company-classifier.service';
import { UpdateCompanyDto } from './dto/update-company.dto';

@Injectable()
export class CompaniesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly classifier: CompanyClassifierService,
  ) {}

  async getMine(companyId: string) {
    const company = await this.prisma.company.findUnique({ where: { id: companyId } });
    if (!company) throw new NotFoundException('Company not found');
    return {
      company,
      uiConfig: this.classifier.getUiConfig(company.classification),
    };
  }

  async updateMine(companyId: string, dto: UpdateCompanyDto) {
    const existing = await this.prisma.company.findUnique({ where: { id: companyId } });
    if (!existing) throw new NotFoundException('Company not found');

    const merged = { ...existing, ...dto };
    const classified = this.classifier.classify(merged);
    const company = await this.prisma.company.update({
      where: { id: companyId },
      data: { ...dto, ...classified },
    });

    return {
      company,
      uiConfig: this.classifier.getUiConfig(company.classification),
    };
  }
}
