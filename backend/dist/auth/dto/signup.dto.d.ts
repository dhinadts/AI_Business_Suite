import { CreateCompanyDto } from '../../companies/dto/create-company.dto';
export declare class SignupDto {
    fullName: string;
    email: string;
    phone?: string;
    password: string;
    company: CreateCompanyDto;
}
