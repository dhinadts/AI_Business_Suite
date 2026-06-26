import 'package:flutter/material.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../../core/layout/responsive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../prototype_screens.dart' show MetricGrid, ScreenHeader;

class GroceryDashboardScreen extends ConsumerWidget {
  const GroceryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(authProvider).session!.uiConfig;
    return AppScaffold(
      title: 'Grocery Dashboard',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: ui.dashboardTitle,
            subtitle:
                'Simple store mode enabled for billing, stock, customers, expenses, and daily sales.',
          ),
          const MetricGrid(
            children: [
              StatCard(
                title: 'Today Sales',
                value: '₹42.8K',
                delta: '+8%',
                icon: Icons.storefront_rounded,
                chartValues: [22, 26, 29, 34, 38, 42.8],
              ),
              StatCard(
                title: 'Bills',
                value: '126',
                delta: '+14',
                icon: Icons.receipt_rounded,
                chartValues: [74, 86, 95, 108, 118, 126],
              ),
              StatCard(
                title: 'Low Stock',
                value: '18',
                delta: 'Low',
                icon: Icons.inventory_rounded,
                chartValues: [34, 30, 26, 22, 20, 18],
              ),
              StatCard(
                title: 'UPI Share',
                value: '64%',
                delta: '+6%',
                icon: Icons.qr_code_rounded,
                chartValues: [44, 49, 54, 58, 61, 64],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _QuickActions(actions: ui.quickActions),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.actions});
  final List<String> actions;
  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: 'Quick actions',
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final action in actions)
              FilledButton(onPressed: () {}, child: Text(action)),
          ],
        ),
      ],
    );
  }
}
