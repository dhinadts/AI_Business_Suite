import { CompaniesService } from './companies.service';
import { UpdateCompanyDto } from './dto/update-company.dto';
export declare class CompaniesController {
    private readonly companiesService;
    constructor(companiesService: CompaniesService);
    getMine(user: {
        companyId: string;
    }): Promise<{
        company: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            industry: string | null;
            state: string | null;
            legalName: string;
            tradeName: string | null;
            businessType: import(".prisma/client").$Enums.BusinessType;
            gstin: string | null;
            udyamNumber: string | null;
            pan: string | null;
            city: string | null;
            address: string | null;
            pincode: string | null;
            employeeCount: number;
            monthlyRevenue: number;
            branchCount: number;
            skuCount: number;
            invoiceVolume: number;
            hasGST: boolean;
            classification: import(".prisma/client").$Enums.BusinessClassification;
            uiPreset: import(".prisma/client").$Enums.UiPreset;
            onboardingCompleted: boolean;
        };
        uiConfig: import("./company-classifier.service").UiConfig;
    }>;
    updateMine(user: {
        companyId: string;
    }, dto: UpdateCompanyDto): Promise<{
        company: {
            id: string;
            createdAt: Date;
            updatedAt: Date;
            industry: string | null;
            state: string | null;
            legalName: string;
            tradeName: string | null;
            businessType: import(".prisma/client").$Enums.BusinessType;
            gstin: string | null;
            udyamNumber: string | null;
            pan: string | null;
            city: string | null;
            address: string | null;
            pincode: string | null;
            employeeCount: number;
            monthlyRevenue: number;
            branchCount: number;
            skuCount: number;
            invoiceVolume: number;
            hasGST: boolean;
            classification: import(".prisma/client").$Enums.BusinessClassification;
            uiPreset: import(".prisma/client").$Enums.UiPreset;
            onboardingCompleted: boolean;
        };
        uiConfig: import("./company-classifier.service").UiConfig;
    }>;
}
