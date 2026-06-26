import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/responsive_scaffold.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../prototype_screens.dart' show ModuleGrid, ScreenHeader;

class LargeBusinessDashboardScreen extends ConsumerWidget {
  const LargeBusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(authProvider).session!.uiConfig;
    return AppScaffold(
      title: 'Enterprise Control Center',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: ui.dashboardTitle,
            subtitle:
                'Enterprise mode enabled. Multi-branch control, approvals, analytics, compliance, and department views are prioritized.',
          ),
          ModuleGrid(
            modules: [
              for (final module in ui.primaryModules)
                ModuleCard(
                  title: module,
                  subtitle: 'Enterprise control for $module',
                  icon: Icons.domain_rounded,
                  onTap: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
