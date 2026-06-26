import '../../../core/models/association_models.dart';
import '../../../core/network/api_client.dart';

class AssociationsApi {
  const AssociationsApi(this.client);

  final ApiClient client;

  Future<
    ({List<AssociationSummary> associations, List<AssociationNotice> notices})
  >
  loadCenter() async {
    final responses = await Future.wait([
      client.dio.get<Map<String, dynamic>>('/associations/me'),
      client.dio.get<Map<String, dynamic>>('/associations/notifications'),
    ]);

    final associationsJson =
        responses[0].data?['associations'] as List<dynamic>? ?? [];
    final noticesJson =
        responses[1].data?['notifications'] as List<dynamic>? ?? [];

    return (
      associations: associationsJson
          .cast<Map<String, dynamic>>()
          .map(AssociationSummary.fromJson)
          .toList(),
      notices: noticesJson
          .cast<Map<String, dynamic>>()
          .map(AssociationNotice.fromJson)
          .toList(),
    );
  }

  Future<void> publishNotice({
    required String associationId,
    required String title,
    required String body,
    required AssociationNotificationSeverity severity,
    List<String> targetStates = const [],
    List<String> targetTypes = const [],
  }) async {
    await client.dio.post<void>(
      '/associations/$associationId/notifications',
      data: {
        'title': title,
        'body': body,
        'severity': severity.apiValue,
        'actionLabel': 'Open notice',
        'actionUrl': '/notifications',
        'targetStates': targetStates,
        'targetTypes': targetTypes,
      },
    );
  }

  Future<void> registerDeviceToken({
    required String token,
    required String platform,
  }) async {
    await client.dio.post<void>(
      '/associations/device-token',
      data: {'token': token, 'platform': platform},
    );
  }
}
