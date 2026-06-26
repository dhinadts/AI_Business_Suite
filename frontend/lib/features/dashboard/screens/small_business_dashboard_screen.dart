import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/responsive_scaffold.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../prototype_screens.dart' show ModuleGrid, ScreenHeader;

class SmallBusinessDashboardScreen extends ConsumerWidget {
  const SmallBusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(authProvider).session!.uiConfig;
    return AppScaffold(
      title: 'Business Dashboard',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: ui.dashboardTitle,
            subtitle:
                'MSME basic mode enabled. Billing, GST, accounting, inventory, CRM, and reports are ready.',
          ),
          ModuleGrid(
            modules: [
              for (final module in ui.primaryModules)
                ModuleCard(
                  title: module,
                  subtitle: 'Open $module workspace',
                  icon: Icons.apps_rounded,
                  onTap: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
