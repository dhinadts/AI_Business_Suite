import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import 'grocery_dashboard_screen.dart';
import 'large_business_dashboard_screen.dart';
import 'medium_business_dashboard_screen.dart';
import 'small_business_dashboard_screen.dart';

class AdaptiveDashboardScreen extends ConsumerWidget {
  const AdaptiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authProvider).session;
    return switch (session?.company.uiPreset) {
      'GROCERY_SIMPLE' => const GroceryDashboardScreen(),
      'MSME_GROWTH' => const MediumBusinessDashboardScreen(),
      'ENTERPRISE_ADVANCED' => const LargeBusinessDashboardScreen(),
      _ => const SmallBusinessDashboardScreen(),
    };
  }
}
