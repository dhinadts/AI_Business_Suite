import '../../../core/models/company_model.dart';
import '../../../core/models/ui_config_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/storage/app_local_storage.dart';
import 'auth_api.dart';

class AuthSession {
  const AuthSession({
    required this.accessToken,
    required this.user,
    required this.company,
    required this.uiConfig,
  });

  final String accessToken;
  final UserModel user;
  final CompanyModel company;
  final UiConfigModel uiConfig;

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'user': user.toJson(),
    'company': company.toJson(),
    'uiConfig': uiConfig.toJson(),
  };

  AuthSession copyWith({UserModel? user, CompanyModel? company}) {
    return AuthSession(
      accessToken: accessToken,
      user: user ?? this.user,
      company: company ?? this.company,
      uiConfig: uiConfig,
    );
  }

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: json['accessToken']?.toString() ?? '',
      user: UserModel.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      company: CompanyModel.fromJson(
        Map<String, dynamic>.from(json['company'] as Map),
      ),
      uiConfig: UiConfigModel.fromJson(
        Map<String, dynamic>.from(json['uiConfig'] as Map),
      ),
    );
  }
}

class AuthRepository {
  AuthRepository(this.api, this.storage);

  final AuthApi api;
  final AppLocalStorage storage;

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final data = await api.login({'email': email, 'password': password});
    return _persist(data);
  }

  Future<AuthSession> signup(Map<String, dynamic> payload) async {
    final data = await api.signup(payload);
    return _persist(data);
  }

  Future<AuthSession?> restore() async {
    final token = await storage.readToken();
    if (token == null) return null;
    final cached = await storage.readSession();
    if (cached != null) return AuthSession.fromJson(cached);
    try {
      final data = await api.me();
      final session = _sessionFromData(token, data);
      await storage.saveSession(session.toJson());
      return session;
    } catch (_) {
      if (cached != null) return AuthSession.fromJson(cached);
      rethrow;
    }
  }

  Future<void> logout() => storage.clearAuth();

  Future<void> saveSession(AuthSession session) async {
    await storage.saveToken(session.accessToken);
    await storage.saveSession(session.toJson());
  }

  Future<AuthSession> _persist(Map<String, dynamic> data) async {
    final token = data['accessToken']?.toString() ?? '';
    final session = _sessionFromData(token, data);
    await saveSession(session);
    return session;
  }

  AuthSession _sessionFromData(String token, Map<String, dynamic> data) {
    return AuthSession(
      accessToken: token,
      user: UserModel.fromJson(Map<String, dynamic>.from(data['user'] as Map)),
      company: CompanyModel.fromJson(
        Map<String, dynamic>.from(data['company'] as Map),
      ),
      uiConfig: UiConfigModel.fromJson(
        Map<String, dynamic>.from(data['uiConfig'] as Map),
      ),
    );
  }
}
