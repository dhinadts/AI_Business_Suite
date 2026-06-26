class UiConfigModel {
  const UiConfigModel({
    required this.uiPreset,
    required this.dashboardTitle,
    required this.primaryModules,
    required this.quickActions,
    this.hiddenModules = const [],
    this.showSimpleBilling = false,
    this.showGSTAdvanced = false,
    this.showAIRecommendations = false,
    this.showDepartmentViews = false,
    this.showAdvancedAnalytics = false,
    this.showRoleDashboards = false,
  });

  final String uiPreset;
  final String dashboardTitle;
  final List<String> primaryModules;
  final List<String> quickActions;
  final List<String> hiddenModules;
  final bool showSimpleBilling;
  final bool showGSTAdvanced;
  final bool showAIRecommendations;
  final bool showDepartmentViews;
  final bool showAdvancedAnalytics;
  final bool showRoleDashboards;

  factory UiConfigModel.fromJson(Map<String, dynamic> json) {
    List<String> list(String key) => [
      for (final item in (json[key] as List? ?? const [])) item.toString(),
    ];
    return UiConfigModel(
      uiPreset: json['uiPreset']?.toString() ?? 'MSME_BASIC',
      dashboardTitle:
          json['dashboardTitle']?.toString() ?? 'Business Dashboard',
      primaryModules: list('primaryModules'),
      quickActions: list('quickActions'),
      hiddenModules: list('hiddenModules'),
      showSimpleBilling: json['showSimpleBilling'] == true,
      showGSTAdvanced: json['showGSTAdvanced'] == true,
      showAIRecommendations: json['showAIRecommendations'] == true,
      showDepartmentViews: json['showDepartmentViews'] == true,
      showAdvancedAnalytics: json['showAdvancedAnalytics'] == true,
      showRoleDashboards: json['showRoleDashboards'] == true,
    );
  }
}
