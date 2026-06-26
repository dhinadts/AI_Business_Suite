import 'dart:async';
import '../../app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../features/auth/data/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../features/associations/providers/associations_provider.dart';

final fcmNotificationServiceProvider = Provider<FcmNotificationService>(
  (ref) => FcmNotificationService(ref),
);

class FcmNotificationService {
  FcmNotificationService(this.ref);

  final Ref ref;
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  String? _lastSessionToken;

  Future<void> syncForSession(AuthSession? session) async {
    if (session == null) return;
    if (_lastSessionToken == session.accessToken) return;
    _lastSessionToken = session.accessToken;
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      final token = await messaging.getToken(
        vapidKey: const String.fromEnvironment('FCM_WEB_VAPID_KEY'),
      );
      if (token != null) {
        await ref
            .read(associationsProvider.notifier)
            .registerDeviceToken(token: token, platform: _platform);
      }

      await _tokenRefreshSubscription?.cancel();
      _tokenRefreshSubscription = messaging.onTokenRefresh.listen((newToken) {
        ref
            .read(associationsProvider.notifier)
            .registerDeviceToken(token: newToken, platform: _platform);
      });
    } catch (_) {
      // FCM can be unavailable in local web builds or unsigned installs.
    }
  }

  void attachForegroundHandler(GlobalKey<ScaffoldMessengerState> messengerKey) {
    _foregroundSubscription ??= FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final title =
          notification?.title ?? message.data['title'] ?? 'Association alert';
      final body = notification?.body ?? message.data['body'] ?? '';
      final severity = message.data['severity'] ?? 'INFO';
      final messenger = messengerKey.currentState;
      if (messenger == null) return;
      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 6),
          backgroundColor: _colorForSeverity(severity),
          content: Row(
            children: [
              const Icon(Icons.campaign_rounded, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    if (body.isNotEmpty)
                      Text(body, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      ref.read(associationsProvider.notifier).load();
    });
  }

  String get _platform {
    if (kIsWeb) return 'WEB';
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'ANDROID',
      TargetPlatform.iOS => 'IOS',
      TargetPlatform.macOS ||
      TargetPlatform.windows ||
      TargetPlatform.linux => 'DESKTOP',
      _ => 'UNKNOWN',
    };
  }

  Color _colorForSeverity(String severity) {
    return switch (severity) {
      'URGENT' => AppColors.red,
      'PRICE_CHANGE' => AppColors.orange,
      'ADVISORY' => AppColors.teal,
      _ => AppColors.navy,
    };
  }
}
