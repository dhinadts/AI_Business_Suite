import { ConflictException, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UserRole } from '@prisma/client';
import * as bcrypt from 'bcrypt';

import { CompanyClassifierService } from '../companies/company-classifier.service';
import { PrismaService } from '../prisma/prisma.service';
import { LoginDto } from './dto/login.dto';
import { SignupDto } from './dto/signup.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly classifier: CompanyClassifierService,
  ) {}

  async signup(dto: SignupDto) {
    const existing = await this.prisma.user.findUnique({ where: { email: dto.email.toLowerCase() } });
    if (existing) throw new ConflictException('Email is already registered');

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
        role: UserRole.OWNER,
        companyId: company.id,
      },
    });

    return this.authResponse(user.id, company.id);
  }

  async login(dto: LoginDto) {
    const user = await this.prisma.user.findUnique({
      where: { email: dto.email.toLowerCase() },
    });
    if (!user) throw new UnauthorizedException('Invalid email or password');

    const valid = await bcrypt.compare(dto.password, user.passwordHash);
    if (!valid) throw new UnauthorizedException('Invalid email or password');

    return this.authResponse(user.id, user.companyId);
  }

  async me(userId: string) {
    const user = await this.prisma.user.findUniqueOrThrow({
      where: { id: userId },
      include: { company: true },
    });
    return this.formatAuthPayload(user, user.company);
  }

  private async authResponse(userId: string, companyId: string) {
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

  private formatAuthPayload(user: any, company: any) {
    const { passwordHash, ...safeUser } = user;
    return {
      user: safeUser,
      company,
      uiConfig: this.classifier.getUiConfig(company.classification),
    };
  }
}
