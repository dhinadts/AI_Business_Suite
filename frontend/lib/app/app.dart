import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business_profile.dart';
import '../core/notifications/fcm_notification_service.dart';
import '../features/associations/providers/associations_provider.dart';
import '../features/auth/providers/auth_provider.dart';
import 'providers.dart';
import 'router.dart';
import 'theme.dart';

final appMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AiBusinessManagerApp extends ConsumerWidget {
  const AiBusinessManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final profile = ref.watch(businessProfileProvider);
    final auth = ref.watch(authProvider);
    final fcm = ref.watch(fcmNotificationServiceProvider);
    fcm.attachForegroundHandler(appMessengerKey);
    ref.listen(authProvider, (previous, next) {
      if (previous?.session?.accessToken != next.session?.accessToken) {
        ref.read(fcmNotificationServiceProvider).syncForSession(next.session);
        if (next.session != null) {
          ref.read(associationsProvider.notifier).ensureLoaded();
        }
      }
    });
    if (auth.session != null) {
      fcm.syncForSession(auth.session);
      ref.read(associationsProvider.notifier).ensureLoaded();
    }
    return MaterialApp.router(
      title: 'AI Business Suite - ${profile.title}',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: appMessengerKey,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
