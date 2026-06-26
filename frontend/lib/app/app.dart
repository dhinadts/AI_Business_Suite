import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business_profile.dart';
import 'providers.dart';
import 'router.dart';
import 'theme.dart';

class AiBusinessManagerApp extends ConsumerWidget {
  const AiBusinessManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final profile = ref.watch(businessProfileProvider);
    return MaterialApp.router(
      title: 'AI Business Suite - ${profile.title}',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
