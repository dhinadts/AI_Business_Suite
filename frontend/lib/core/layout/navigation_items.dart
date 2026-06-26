import 'package:flutter/material.dart';

import '../../app/business_profile.dart';

class NavItem {
  const NavItem(this.label, this.icon, this.path);
  final String label;
  final IconData icon;
  final String path;
}

const primaryNavItems = [
  NavItem('Dashboard', Icons.dashboard_rounded, '/dashboard'),
  NavItem('Billing', Icons.receipt_long_rounded, '/billing'),
  NavItem('Inventory', Icons.inventory_2_rounded, '/inventory'),
  NavItem('CRM', Icons.groups_rounded, '/crm'),
  NavItem('Accounting', Icons.account_balance_wallet_rounded, '/accounting'),
  NavItem('GST', Icons.verified_rounded, '/gst'),
  NavItem('Reports', Icons.bar_chart_rounded, '/reports'),
  NavItem('AI Assistant', Icons.auto_awesome_rounded, '/ai-assistant'),
  NavItem('OCR Upload', Icons.document_scanner_rounded, '/ocr-upload'),
  NavItem('Voice Billing', Icons.mic_rounded, '/voice-billing'),
  NavItem('Settings', Icons.settings_rounded, '/settings'),
];

const mobileNavItems = [
  NavItem('Dashboard', Icons.dashboard_rounded, '/dashboard'),
  NavItem('Billing', Icons.receipt_long_rounded, '/billing'),
  NavItem('Inventory', Icons.inventory_2_rounded, '/inventory'),
  NavItem('Reports', Icons.bar_chart_rounded, '/reports'),
  NavItem('More', Icons.apps_rounded, '/settings'),
];

List<NavItem> primaryNavItemsForProfile(BusinessProfile profile) {
  if (profile.isGrocery) {
    return const [
      NavItem('Store Dashboard', Icons.storefront_rounded, '/dashboard'),
      NavItem(
        'Sale Counter',
        Icons.point_of_sale_rounded,
        '/billing/stall-sale',
      ),
      NavItem('Voice Billing', Icons.mic_rounded, '/voice-billing'),
      NavItem('Inventory', Icons.inventory_2_rounded, '/inventory'),
      NavItem('Scan Stock', Icons.document_scanner_rounded, '/ocr-upload'),
      NavItem('Translator', Icons.translate_rounded, '/translator'),
      NavItem('Printer', Icons.print_rounded, '/printer-setup'),
      NavItem('Reports', Icons.bar_chart_rounded, '/reports'),
      NavItem('Settings', Icons.settings_rounded, '/settings'),
    ];
  }

  if (profile == BusinessProfile.smallRegistered) {
    return const [
      NavItem('Dashboard', Icons.dashboard_rounded, '/dashboard'),
      NavItem('Billing', Icons.receipt_long_rounded, '/billing'),
      NavItem('Inventory', Icons.inventory_2_rounded, '/inventory'),
      NavItem('GST', Icons.verified_rounded, '/gst'),
      NavItem('Reports', Icons.bar_chart_rounded, '/reports'),
      NavItem('Settings', Icons.settings_rounded, '/settings'),
    ];
  }

  if (profile == BusinessProfile.mediumRegistered) {
    return const [
      NavItem('Dashboard', Icons.dashboard_rounded, '/dashboard'),
      NavItem('Billing', Icons.receipt_long_rounded, '/billing'),
      NavItem('Inventory', Icons.inventory_2_rounded, '/inventory'),
      NavItem('CRM', Icons.groups_rounded, '/crm'),
      NavItem(
        'Accounting',
        Icons.account_balance_wallet_rounded,
        '/accounting',
      ),
      NavItem('GST', Icons.verified_rounded, '/gst'),
      NavItem('Reports', Icons.bar_chart_rounded, '/reports'),
      NavItem('AI Assistant', Icons.auto_awesome_rounded, '/ai-assistant'),
      NavItem('Voice Billing', Icons.mic_rounded, '/voice-billing'),
      NavItem('Settings', Icons.settings_rounded, '/settings'),
    ];
  }

  return primaryNavItems;
}

List<NavItem> mobileNavItemsForProfile(BusinessProfile profile) {
  if (profile.isGrocery) {
    return const [
      NavItem('Home', Icons.storefront_rounded, '/dashboard'),
      NavItem('Sale', Icons.point_of_sale_rounded, '/billing/stall-sale'),
      NavItem('Voice', Icons.mic_rounded, '/voice-billing'),
      NavItem('Stock', Icons.inventory_2_rounded, '/inventory'),
      NavItem('More', Icons.apps_rounded, '/settings'),
    ];
  }
  return mobileNavItems;
}

int navIndexForPath(String path, List<NavItem> items) {
  final index = items.indexWhere(
    (item) => path == item.path || path.startsWith('${item.path}/'),
  );
  return index < 0 ? 0 : index;
}
