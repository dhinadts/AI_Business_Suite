enum BusinessProfile {
  smallRegistered,
  mediumRegistered,
  largeRegistered,
  groceryStore,
}

extension BusinessProfileInfo on BusinessProfile {
  String get buildValue => switch (this) {
    BusinessProfile.smallRegistered => 'small',
    BusinessProfile.mediumRegistered => 'medium',
    BusinessProfile.largeRegistered => 'large',
    BusinessProfile.groceryStore => 'grocery',
  };

  String get title => switch (this) {
    BusinessProfile.smallRegistered => 'Small Registered Company',
    BusinessProfile.mediumRegistered => 'Medium Registered Company',
    BusinessProfile.largeRegistered => 'Large Registered Company',
    BusinessProfile.groceryStore => 'Grocery & Department Store',
  };

  String get dashboardTitle => switch (this) {
    BusinessProfile.smallRegistered => 'Simple registered business dashboard',
    BusinessProfile.mediumRegistered => 'Growth business operations dashboard',
    BusinessProfile.largeRegistered => 'Enterprise ERP command center',
    BusinessProfile.groceryStore => 'Store billing counter',
  };

  String get dashboardSubtitle => switch (this) {
    BusinessProfile.smallRegistered =>
      'Invoices, GST reminders, stock, and daily receivables for small registered companies.',
    BusinessProfile.mediumRegistered =>
      'Billing, inventory, CRM, GST, and reports for growing registered companies.',
    BusinessProfile.largeRegistered =>
      'Department-wise ERP views, accounting controls, compliance, reports, and AI operations.',
    BusinessProfile.groceryStore =>
      'Fast manual billing, voice billing, shelf stock, low-stock alerts, and daily sales.',
  };

  bool get isGrocery => this == BusinessProfile.groceryStore;
  bool get showCrm => this != BusinessProfile.groceryStore;
  bool get showAccounting =>
      this == BusinessProfile.mediumRegistered ||
      this == BusinessProfile.largeRegistered;
  bool get showGst => this != BusinessProfile.groceryStore;
  bool get showOcr =>
      this == BusinessProfile.mediumRegistered ||
      this == BusinessProfile.largeRegistered;
  bool get showAi => this != BusinessProfile.smallRegistered;

  static BusinessProfile fromBuildValue(String value) {
    final normalized = value.trim().toLowerCase();
    return switch (normalized) {
      'small' ||
      'small_registered' ||
      'small-registered' => BusinessProfile.smallRegistered,
      'medium' ||
      'medium_registered' ||
      'medium-registered' => BusinessProfile.mediumRegistered,
      'large' ||
      'large_registered' ||
      'large-registered' => BusinessProfile.largeRegistered,
      'grocery' ||
      'store' ||
      'grocery_store' ||
      'departmental' => BusinessProfile.groceryStore,
      _ => BusinessProfile.mediumRegistered,
    };
  }
}

const buildProfile = String.fromEnvironment(
  'BUSINESS_PROFILE',
  defaultValue: 'grocery',
);
