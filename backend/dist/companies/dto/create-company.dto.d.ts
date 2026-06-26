import { BusinessType } from '@prisma/client';
export declare class CreateCompanyDto {
    legalName: string;
    tradeName?: string;
    businessType: BusinessType;
    industry?: string;
    gstin?: string;
    udyamNumber?: string;
    pan?: string;
    state?: string;
    city?: string;
    address?: string;
    pincode?: string;
    employeeCount: number;
    monthlyRevenue: number;
    branchCount: number;
    skuCount: number;
    invoiceVolume: number;
    hasGST: boolean;
}
