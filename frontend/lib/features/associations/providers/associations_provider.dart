import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/models/association_models.dart';
import '../../auth/providers/auth_provider.dart';
import '../data/associations_api.dart';

final associationsApiProvider = Provider<AssociationsApi>(
  (ref) => AssociationsApi(ref.watch(apiClientProvider)),
);

final associationsProvider =
    StateNotifierProvider<AssociationsNotifier, AssociationsState>((ref) {
      return AssociationsNotifier(ref.watch(associationsApiProvider));
    });

class AssociationsState {
  const AssociationsState({
    this.loading = true,
    this.associations = const [],
    this.notices = const [],
    this.error,
  });

  final bool loading;
  final List<AssociationSummary> associations;
  final List<AssociationNotice> notices;
  final String? error;

  AssociationSummary? get firstPublisher {
    for (final association in associations) {
      if (association.canPublish) return association;
    }
    return null;
  }

  int get unreadCount => notices
      .where(
        (notice) => DateTime.now().difference(notice.createdAt).inHours < 24,
      )
      .length;

  AssociationsState copyWith({
    bool? loading,
    List<AssociationSummary>? associations,
    List<AssociationNotice>? notices,
    String? error,
    bool clearError = false,
  }) {
    return AssociationsState(
      loading: loading ?? this.loading,
      associations: associations ?? this.associations,
      notices: notices ?? this.notices,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class AssociationsNotifier extends StateNotifier<AssociationsState> {
  AssociationsNotifier(this.api) : super(const AssociationsState());

  final AssociationsApi api;
  bool _loaded = false;

  Future<void> ensureLoaded() {
    if (_loaded) return Future.value();
    return load();
  }

  Future<void> load() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final data = await api.loadCenter();
      _loaded = true;
      state = AssociationsState(
        loading: false,
        associations: data.associations,
        notices: data.notices,
      );
    } catch (error) {
      state = state.copyWith(loading: false, error: error.toString());
    }
  }

  Future<void> publish({
    required AssociationSummary association,
    required String title,
    required String body,
    required AssociationNotificationSeverity severity,
    List<String> targetStates = const [],
    List<String> targetTypes = const [],
  }) async {
    await api.publishNotice(
      associationId: association.id,
      title: title,
      body: body,
      severity: severity,
      targetStates: targetStates,
      targetTypes: targetTypes,
    );
    await load();
  }

  Future<void> registerDeviceToken({
    required String token,
    required String platform,
  }) {
    return api.registerDeviceToken(token: token, platform: platform);
  }
}
