import '../data/auth_api.dart';
import '../data/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/network/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage_service.dart';

final secureStorageProvider = Provider<SecureStorageService>(
  (ref) => SecureStorageService(),
);
final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(secureStorageProvider)),
);
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = AuthApi(ref.watch(apiClientProvider));
  return AuthRepository(api, ref.watch(secureStorageProvider));
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

class SignupDraft {
  const SignupDraft({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
}

class AuthState {
  const AuthState({
    this.loading = true,
    this.session,
    this.error,
    this.signupDraft,
    this.justSignedUp = false,
  });

  final bool loading;
  final AuthSession? session;
  final String? error;
  final SignupDraft? signupDraft;
  final bool justSignedUp;

  bool get isAuthenticated => session != null;

  AuthState copyWith({
    bool? loading,
    AuthSession? session,
    String? error,
    SignupDraft? signupDraft,
    bool? justSignedUp,
    bool clearSession = false,
    bool clearError = false,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      session: clearSession ? null : session ?? this.session,
      error: clearError ? null : error ?? this.error,
      signupDraft: signupDraft ?? this.signupDraft,
      justSignedUp: justSignedUp ?? this.justSignedUp,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.repository) : super(const AuthState()) {
    restore();
  }

  final AuthRepository repository;

  void saveSignupDraft(SignupDraft draft) {
    state = state.copyWith(signupDraft: draft, clearError: true);
  }

  Future<void> restore() async {
    try {
      final session = await repository.restore();
      state = AuthState(loading: false, session: session);
    } catch (_) {
      await repository.logout();
      state = const AuthState(loading: false);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(
      loading: true,
      clearError: true,
      justSignedUp: false,
    );
    try {
      final session = await repository.login(email: email, password: password);
      state = AuthState(loading: false, session: session);
    } catch (error) {
      state = AuthState(loading: false, error: _message(error));
    }
  }

  Future<void> signupWithCompany(Map<String, dynamic> company) async {
    final draft = state.signupDraft;
    if (draft == null) {
      state = state.copyWith(error: 'Signup details are missing.');
      return;
    }

    state = state.copyWith(loading: true, clearError: true);
    try {
      final session = await repository.signup({
        'fullName': draft.fullName,
        'email': draft.email,
        'phone': draft.phone,
        'password': draft.password,
        'company': company,
      });
      state = AuthState(
        loading: false,
        session: session,
        signupDraft: draft,
        justSignedUp: true,
      );
    } catch (error) {
      state = state.copyWith(loading: false, error: _message(error));
    }
  }

  Future<void> logout() async {
    await repository.logout();
    state = const AuthState(loading: false);
  }

  void consumeSignupFlag() {
    state = state.copyWith(justSignedUp: false);
  }

  String _message(Object error) {
    final text = error.toString();
    return text.contains('SocketException')
        ? 'Cannot connect to backend API.'
        : text;
  }
}
