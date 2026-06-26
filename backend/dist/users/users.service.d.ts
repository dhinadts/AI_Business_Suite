import { PrismaService } from '../prisma/prisma.service';
export declare class UsersService {
    private readonly prisma;
    constructor(prisma: PrismaService);
    findByEmail(email: string): import(".prisma/client").Prisma.Prisma__UserClient<{
        id: string;
        companyId: string;
        role: import(".prisma/client").$Enums.UserRole;
        createdAt: Date;
        updatedAt: Date;
        fullName: string;
        email: string;
        phone: string | null;
        passwordHash: string;
    } | null, null, import("@prisma/client/runtime/library").DefaultArgs, import(".prisma/client").Prisma.PrismaClientOptions>;
    findById(id: string): import(".prisma/client").Prisma.Prisma__UserClient<({
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
