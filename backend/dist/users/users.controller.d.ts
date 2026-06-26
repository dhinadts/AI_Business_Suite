import { UsersService } from './users.service';
export declare class UsersController {
    private readonly usersService;
    constructor(usersService: UsersService);
    me(user: {
        sub: string;
    }): import(".prisma/client").Prisma.Prisma__UserClient<({
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
    } & {
        id: string;
        companyId: string;
        role: import(".prisma/client").$Enums.UserRole;
        createdAt: Date;
        updatedAt: Date;
        fullName: string;
        email: string;
        phone: string | null;
        passwordHash: string;
    }) | null, null, import("@prisma/client/runtime/library").DefaultArgs, import(".prisma/client").Prisma.PrismaClientOptions>;
}
