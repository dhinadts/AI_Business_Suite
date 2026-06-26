import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/responsive_scaffold.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';
import '../../prototype_screens.dart' show ModuleGrid, ScreenHeader;

class MediumBusinessDashboardScreen extends ConsumerWidget {
  const MediumBusinessDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(authProvider).session!.uiConfig;
    return AppScaffold(
      title: 'Growth Command Center',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: ui.dashboardTitle,
            subtitle:
                'Growth mode enabled. Team workflows, purchase, HRMS, advanced inventory, and AI insights are prioritized.',
          ),
          ModuleGrid(
            modules: [
              for (final module in ui.primaryModules)
                ModuleCard(
                  title: module,
                  subtitle: 'Growth workflow for $module',
                  icon: Icons.trending_up_rounded,
                  onTap: () {},
                ),
            ],
          ),
        ],
      ),
    );
  }
}
