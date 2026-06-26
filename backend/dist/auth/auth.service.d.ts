import { JwtService } from '@nestjs/jwt';
import { CompanyClassifierService } from '../companies/company-classifier.service';
import { PrismaService } from '../prisma/prisma.service';
import { LoginDto } from './dto/login.dto';
import { SignupDto } from './dto/signup.dto';
export declare class AuthService {
    private readonly prisma;
    private readonly jwtService;
    private readonly classifier;
    constructor(prisma: PrismaService, jwtService: JwtService, classifier: CompanyClassifierService);
    signup(dto: SignupDto): Promise<{
        user: any;
        company: any;
        uiConfig: import("../companies/company-classifier.service").UiConfig;
        accessToken: string;
    }>;
    login(dto: LoginDto): Promise<{
        user: any;
        company: any;
        uiConfig: import("../companies/company-classifier.service").UiConfig;
        accessToken: string;
    }>;
    me(userId: string): Promise<{
        user: any;
        company: any;
        uiConfig: import("../companies/company-classifier.service").UiConfig;
    }>;
    private authResponse;
    private formatAuthPayload;
}
