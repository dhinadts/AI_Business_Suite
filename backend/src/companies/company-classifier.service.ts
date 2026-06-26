import { Injectable } from '@nestjs/common';
import { BusinessClassification, BusinessType, Company, UiPreset } from '@prisma/client';

type ClassificationInput = Pick<
  Company,
  'businessType' | 'employeeCount' | 'monthlyRevenue' | 'branchCount' | 'skuCount' | 'invoiceVolume'
>;

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

@Injectable()
export class CompanyClassifierService {
  classify(input: ClassificationInput): {
    classification: BusinessClassification;
    uiPreset: UiPreset;
  } {
    const isGrocerySimple =
      input.businessType === BusinessType.GROCERY &&
      input.employeeCount <= 5 &&
      input.branchCount <= 1 &&
      input.skuCount <= 1000 &&
      input.monthlyRevenue <= 500000 &&
      input.invoiceVolume <= 500;

    if (isGrocerySimple) {
      return {
        classification: BusinessClassification.NORMAL_GROCERY_STORE,
        uiPreset: UiPreset.GROCERY_SIMPLE,
      };
    }

    const large =
      input.employeeCount > 100 ||
      input.monthlyRevenue > 20000000 ||
      input.branchCount > 10 ||
      input.invoiceVolume > 20000;
    if (large) {
      return {
        classification: BusinessClassification.LARGE_BUSINESS,
        uiPreset: UiPreset.ENTERPRISE_ADVANCED,
      };
    }

    const medium =
      input.employeeCount <= 100 &&
      input.monthlyRevenue <= 20000000 &&
      input.branchCount <= 10 &&
      input.invoiceVolume <= 20000;
    if (medium && (input.employeeCount > 20 || input.monthlyRevenue > 2500000 || input.branchCount > 2 || input.invoiceVolume > 2000)) {
      return {
        classification: BusinessClassification.MEDIUM_BUSINESS,
        uiPreset: UiPreset.MSME_GROWTH,
      };
    }

    return {
      classification: BusinessClassification.SMALL_BUSINESS,
      uiPreset: UiPreset.MSME_BASIC,
    };
  }

  getUiConfig(classification: BusinessClassification): UiConfig {
    switch (classification) {
      case BusinessClassification.NORMAL_GROCERY_STORE:
        return {
          uiPreset: UiPreset.GROCERY_SIMPLE,
          dashboardTitle: "Today's Store Summary",
          primaryModules: ['Billing', 'Inventory', 'Customers', 'Expenses', 'Reports'],
          hiddenModules: ['Manufacturing', 'HRMS', 'Advanced Procurement'],
          quickActions: ['New Bill', 'Add Product', 'Scan Invoice', 'Daily Sales'],
          showSimpleBilling: true,
          showGSTAdvanced: false,
          showAIRecommendations: true,
        };
      case BusinessClassification.SMALL_BUSINESS:
        return {
          uiPreset: UiPreset.MSME_BASIC,
          dashboardTitle: 'Business Dashboard',
          primaryModules: ['Billing', 'Inventory', 'CRM', 'GST', 'Accounting', 'Reports'],
          quickActions: ['Create Invoice', 'Add Customer', 'Record Expense', 'GST Summary'],
          showSimpleBilling: false,
          showGSTAdvanced: true,
        };
      case BusinessClassification.MEDIUM_BUSINESS:
        return {
          uiPreset: UiPreset.MSME_GROWTH,
          dashboardTitle: 'Growth Command Center',
          primaryModules: ['Billing', 'Inventory', 'CRM', 'Accounting', 'GST', 'HRMS', 'Purchase', 'Reports'],
          quickActions: ['Create Invoice', 'Purchase Order', 'Stock Alert', 'Team Task', 'AI Insight'],
          showDepartmentViews: true,
        };
      case BusinessClassification.LARGE_BUSINESS:
        return {
          uiPreset: UiPreset.ENTERPRISE_ADVANCED,
          dashboardTitle: 'Enterprise Control Center',
          primaryModules: ['Finance', 'Inventory', 'CRM', 'HRMS', 'Procurement', 'Manufacturing', 'Analytics', 'Admin'],
          quickActions: ['Executive Report', 'Approval Queue', 'Multi-Branch Stock', 'Compliance Review'],
          showAdvancedAnalytics: true,
          showRoleDashboards: true,
        };
    }
  }
}
