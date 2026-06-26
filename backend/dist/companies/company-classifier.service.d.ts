import { BusinessClassification, Company, UiPreset } from '@prisma/client';
type ClassificationInput = Pick<Company, 'businessType' | 'employeeCount' | 'monthlyRevenue' | 'branchCount' | 'skuCount' | 'invoiceVolume'>;
export type UiConfig = {
    uiPreset: UiPreset;
    dashboardTitle: string;
    primaryModules: string[];
    hiddenModules?: string[];
    quickActions: string[];
    showSimpleBilling?: boolean;
    showGSTAdvanced?: boolean;
    showAIRecommendations?: boolean;
    showDepartmentViews?: boolean;
    showAdvancedAnalytics?: boolean;
    showRoleDashboards?: boolean;
};
export declare class CompanyClassifierService {
    classify(input: ClassificationInput): {
        classification: BusinessClassification;
        uiPreset: UiPreset;
    };
    getUiConfig(classification: BusinessClassification): UiConfig;
}
export {};
