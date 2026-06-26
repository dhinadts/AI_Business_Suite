import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { SignupDto } from './dto/signup.dto';
export declare class AuthController {
    private readonly authService;
    constructor(authService: AuthService);
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
    me(user: {
        sub: string;
    }): Promise<{
        user: any;
        company: any;
        uiConfig: import("../companies/company-classifier.service").UiConfig;
    }>;
}
