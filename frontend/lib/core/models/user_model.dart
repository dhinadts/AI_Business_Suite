class UserModel {
  const UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    required this.role,
    required this.companyId,
  });

  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String role;
  final String companyId;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
      role: json['role']?.toString() ?? 'OWNER',
      companyId: json['companyId']?.toString() ?? '',
    );
  }

  UserModel copyWith({String? fullName, String? email, String? phone}) {
    return UserModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role,
      companyId: companyId,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'role': role,
    'companyId': companyId,
  };
}
