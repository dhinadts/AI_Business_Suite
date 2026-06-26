"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.CompanyClassifierService = void 0;
const common_1 = require("@nestjs/common");
const client_1 = require("@prisma/client");
let CompanyClassifierService = class CompanyClassifierService {
    classify(input) {
        const isGrocerySimple = input.businessType === client_1.BusinessType.GROCERY &&
            input.employeeCount <= 5 &&
            input.branchCount <= 1 &&
            input.skuCount <= 1000 &&
            input.monthlyRevenue <= 500000 &&
            input.invoiceVolume <= 500;
        if (isGrocerySimple) {
            return {
                classification: client_1.BusinessClassification.NORMAL_GROCERY_STORE,
                uiPreset: client_1.UiPreset.GROCERY_SIMPLE,
            };
        }
        const large = input.employeeCount > 100 ||
            input.monthlyRevenue > 20000000 ||
            input.branchCount > 10 ||
            input.invoiceVolume > 20000;
        if (large) {
            return {
                classification: client_1.BusinessClassification.LARGE_BUSINESS,
                uiPreset: client_1.UiPreset.ENTERPRISE_ADVANCED,
            };
        }
        const medium = input.employeeCount <= 100 &&
            input.monthlyRevenue <= 20000000 &&
            input.branchCount <= 10 &&
            input.invoiceVolume <= 20000;
        if (medium && (input.employeeCount > 20 || input.monthlyRevenue > 2500000 || input.branchCount > 2 || input.invoiceVolume > 2000)) {
            return {
                classification: client_1.BusinessClassification.MEDIUM_BUSINESS,
                uiPreset: client_1.UiPreset.MSME_GROWTH,
            };
        }
        return {
            classification: client_1.BusinessClassification.SMALL_BUSINESS,
            uiPreset: client_1.UiPreset.MSME_BASIC,
        };
    }
    getUiConfig(classification) {
        switch (classification) {
            case client_1.BusinessClassification.NORMAL_GROCERY_STORE:
                return {
                    uiPreset: client_1.UiPreset.GROCERY_SIMPLE,
                    dashboardTitle: "Today's Store Summary",
                    primaryModules: ['Billing', 'Inventory', 'Customers', 'Expenses', 'Reports'],
                    hiddenModules: ['Manufacturing', 'HRMS', 'Advanced Procurement'],
                    quickActions: ['New Bill', 'Add Product', 'Scan Invoice', 'Daily Sales'],
                    showSimpleBilling: true,
                    showGSTAdvanced: false,
                    showAIRecommendations: true,
                };
            case client_1.BusinessClassification.SMALL_BUSINESS:
                return {
                    uiPreset: client_1.UiPreset.MSME_BASIC,
                    dashboardTitle: 'Business Dashboard',
                    primaryModules: ['Billing', 'Inventory', 'CRM', 'GST', 'Accounting', 'Reports'],
                    quickActions: ['Create Invoice', 'Add Customer', 'Record Expense', 'GST Summary'],
                    showSimpleBilling: false,
                    showGSTAdvanced: true,
                };
            case client_1.BusinessClassification.MEDIUM_BUSINESS:
                return {
                    uiPreset: client_1.UiPreset.MSME_GROWTH,
                    dashboardTitle: 'Growth Command Center',
                    primaryModules: ['Billing', 'Inventory', 'CRM', 'Accounting', 'GST', 'HRMS', 'Purchase', 'Reports'],
                    quickActions: ['Create Invoice', 'Purchase Order', 'Stock Alert', 'Team Task', 'AI Insight'],
                    showDepartmentViews: true,
                };
            case client_1.BusinessClassification.LARGE_BUSINESS:
                return {
                    uiPreset: client_1.UiPreset.ENTERPRISE_ADVANCED,
                    dashboardTitle: 'Enterprise Control Center',
                    primaryModules: ['Finance', 'Inventory', 'CRM', 'HRMS', 'Procurement', 'Manufacturing', 'Analytics', 'Admin'],
                    quickActions: ['Executive Report', 'Approval Queue', 'Multi-Branch Stock', 'Compliance Review'],
                    showAdvancedAnalytics: true,
                    showRoleDashboards: true,
                };
        }
    }
};
exports.CompanyClassifierService = CompanyClassifierService;
exports.CompanyClassifierService = CompanyClassifierService = __decorate([
    (0, common_1.Injectable)()
], CompanyClassifierService);
