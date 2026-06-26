enum AssociationRole {
  head,
  subHead,
  financialSecretary,
  treasurer,
  member;

  String get label => switch (this) {
    AssociationRole.head => 'Head',
    AssociationRole.subHead => 'Sub Head',
    AssociationRole.financialSecretary => 'Financial Secretary',
    AssociationRole.treasurer => 'Treasurer',
    AssociationRole.member => 'Member',
  };

  bool get canPublish => switch (this) {
    AssociationRole.head ||
    AssociationRole.subHead ||
    AssociationRole.financialSecretary ||
    AssociationRole.treasurer => true,
    AssociationRole.member => false,
  };

  static AssociationRole fromApi(String value) {
    return switch (value) {
      'HEAD' => AssociationRole.head,
      'SUB_HEAD' => AssociationRole.subHead,
      'FINANCIAL_SECRETARY' => AssociationRole.financialSecretary,
      'TREASURER' => AssociationRole.treasurer,
      _ => AssociationRole.member,
    };
  }
}

enum AssociationNotificationSeverity {
  info,
  advisory,
  priceChange,
  urgent;

  String get apiValue => switch (this) {
    AssociationNotificationSeverity.info => 'INFO',
    AssociationNotificationSeverity.advisory => 'ADVISORY',
    AssociationNotificationSeverity.priceChange => 'PRICE_CHANGE',
    AssociationNotificationSeverity.urgent => 'URGENT',
  };

  String get label => switch (this) {
    AssociationNotificationSeverity.info => 'Info',
    AssociationNotificationSeverity.advisory => 'Advisory',
    AssociationNotificationSeverity.priceChange => 'Price Change',
    AssociationNotificationSeverity.urgent => 'Urgent',
  };

  static AssociationNotificationSeverity fromApi(String value) {
    return switch (value) {
      'ADVISORY' => AssociationNotificationSeverity.advisory,
      'PRICE_CHANGE' => AssociationNotificationSeverity.priceChange,
      'URGENT' => AssociationNotificationSeverity.urgent,
      _ => AssociationNotificationSeverity.info,
    };
  }
}

class AssociationSummary {
  const AssociationSummary({
    required this.id,
    required this.name,
    required this.industry,
    required this.role,
    required this.canPublish,
    this.state,
    this.district,
    this.description,
  });

  final String id;
  final String name;
  final String industry;
  final String? state;
  final String? district;
  final String? description;
  final AssociationRole role;
  final bool canPublish;

  factory AssociationSummary.fromJson(Map<String, dynamic> json) {
    final role = AssociationRole.fromApi(json['role'] as String? ?? 'MEMBER');
    return AssociationSummary(
      id: json['id'] as String,
      name: json['name'] as String,
      industry: json['industry'] as String? ?? 'General Trade',
      state: json['state'] as String?,
      district: json['district'] as String?,
      description: json['description'] as String?,
      role: role,
      canPublish: json['canPublish'] as bool? ?? role.canPublish,
    );
  }
}

class AssociationNotice {
  const AssociationNotice({
    required this.id,
    required this.associationName,
    required this.title,
    required this.body,
    required this.severity,
    required this.sentByRole,
    required this.sentCount,
    required this.createdAt,
    this.actionLabel,
    this.actionUrl,
  });

  final String id;
  final String associationName;
  final String title;
  final String body;
  final AssociationNotificationSeverity severity;
  final AssociationRole sentByRole;
  final int sentCount;
  final DateTime createdAt;
  final String? actionLabel;
  final String? actionUrl;

  factory AssociationNotice.fromJson(Map<String, dynamic> json) {
    return AssociationNotice(
      id: json['id'] as String,
      associationName: json['associationName'] as String? ?? 'Association',
      title: json['title'] as String,
      body: json['body'] as String,
      severity: AssociationNotificationSeverity.fromApi(
        json['severity'] as String? ?? 'INFO',
      ),
      sentByRole: AssociationRole.fromApi(json['sentByRole'] as String? ?? ''),
      sentCount: json['sentCount'] as int? ?? 0,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      actionLabel: json['actionLabel'] as String?,
      actionUrl: json['actionUrl'] as String?,
    );
  }
}
