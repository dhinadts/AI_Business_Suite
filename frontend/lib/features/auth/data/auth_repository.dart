import '../../../core/models/company_model.dart';
import '../../../core/models/ui_config_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/storage/secure_storage_service.dart';
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
}

class AuthRepository {
  AuthRepository(this.api, this.storage);

  final AuthApi api;
  final SecureStorageService storage;

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
    final data = await api.me();
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

  Future<void> logout() => storage.clearToken();

  Future<AuthSession> _persist(Map<String, dynamic> data) async {
    final token = data['accessToken']?.toString() ?? '';
    await storage.saveToken(token);
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
