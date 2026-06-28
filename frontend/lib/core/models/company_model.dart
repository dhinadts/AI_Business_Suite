class CompanyModel {
  const CompanyModel({
    required this.id,
    required this.legalName,
    this.tradeName,
    required this.businessType,
    required this.classification,
    required this.uiPreset,
    this.industry,
    this.city,
    this.state,
    this.employeeCount = 1,
    this.monthlyRevenue = 0,
    this.branchCount = 1,
    this.skuCount = 0,
    this.invoiceVolume = 0,
    this.hasGST = false,
  });

  final String id;
  final String legalName;
  final String? tradeName;
  final String businessType;
  final String classification;
  final String uiPreset;
  final String? industry;
  final String? city;
  final String? state;
  final int employeeCount;
  final num monthlyRevenue;
  final int branchCount;
  final int skuCount;
  final int invoiceVolume;
  final bool hasGST;

  String get friendlyClassification {
    return switch (classification) {
      'NORMAL_GROCERY_STORE' => 'Normal Grocery Store',
      'SMALL_BUSINESS' => 'Small Business',
      'MEDIUM_BUSINESS' => 'Medium Business',
      'LARGE_BUSINESS' => 'Large Business',
      _ => classification,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id']?.toString() ?? '',
      legalName: json['legalName']?.toString() ?? '',
      tradeName: json['tradeName']?.toString(),
      businessType: json['businessType']?.toString() ?? 'OTHER',
      classification: json['classification']?.toString() ?? 'SMALL_BUSINESS',
      uiPreset: json['uiPreset']?.toString() ?? 'MSME_BASIC',
      industry: json['industry']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      employeeCount: (json['employeeCount'] as num?)?.toInt() ?? 1,
      monthlyRevenue: json['monthlyRevenue'] as num? ?? 0,
      branchCount: (json['branchCount'] as num?)?.toInt() ?? 1,
      skuCount: (json['skuCount'] as num?)?.toInt() ?? 0,
      invoiceVolume: (json['invoiceVolume'] as num?)?.toInt() ?? 0,
      hasGST: json['hasGST'] == true,
    );
  }

  CompanyModel copyWith({
    String? legalName,
    String? tradeName,
    String? industry,
    String? city,
    String? state,
    bool? hasGST,
  }) {
    return CompanyModel(
      id: id,
      legalName: legalName ?? this.legalName,
      tradeName: tradeName ?? this.tradeName,
      businessType: businessType,
      classification: classification,
      uiPreset: uiPreset,
      industry: industry ?? this.industry,
      city: city ?? this.city,
      state: state ?? this.state,
      employeeCount: employeeCount,
      monthlyRevenue: monthlyRevenue,
      branchCount: branchCount,
      skuCount: skuCount,
      invoiceVolume: invoiceVolume,
      hasGST: hasGST ?? this.hasGST,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'legalName': legalName,
    'tradeName': tradeName,
    'businessType': businessType,
    'classification': classification,
    'uiPreset': uiPreset,
    'industry': industry,
    'city': city,
    'state': state,
    'employeeCount': employeeCount,
    'monthlyRevenue': monthlyRevenue,
    'branchCount': branchCount,
    'skuCount': skuCount,
    'invoiceVolume': invoiceVolume,
    'hasGST': hasGST,
  };
}
