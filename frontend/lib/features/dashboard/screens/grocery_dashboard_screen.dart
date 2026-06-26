import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          const SizedBox(height: 16),
          const _SimpleCounterBilling(),
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
              FilledButton(
                onPressed: () => _openAction(context, action),
                child: Text(action),
              ),
          ],
        ),
      ],
    );
  }

  void _openAction(BuildContext context, String action) {
    final lower = action.toLowerCase();
    if (lower.contains('bill')) {
      context.go('/billing/stall-sale');
    } else if (lower.contains('product')) {
      context.go('/inventory/stock-intake');
    } else if (lower.contains('scan')) {
      context.go('/ocr-upload');
    } else if (lower.contains('sale')) {
      context.go('/reports');
    }
  }
}

class _SimpleCounterBilling extends StatelessWidget {
  const _SimpleCounterBilling();

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 560;
    return FormSectionCard(
      title: 'Simple counter billing',
      trailing: const StatusChip('Ready'),
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: compact ? double.infinity : 260,
              child: const AppTextField(
                label: 'Scan or enter item',
                icon: Icons.qr_code_scanner_rounded,
              ),
            ),
            SizedBox(
              width: compact ? 104 : 120,
              child: const AppTextField(label: 'Qty'),
            ),
            SizedBox(
              width: compact ? 104 : 120,
              child: const AppTextField(label: 'Unit'),
            ),
            SizedBox(
              width: compact ? 116 : 136,
              child: const AppTextField(label: 'Rate'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            StatusChip('kg'),
            StatusChip('gram'),
            StatusChip('litre'),
            StatusChip('packet'),
            StatusChip('piece'),
            StatusChip('UPI'),
            StatusChip('Cash'),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            children: [
              _BillRow('Rice 5kg', '1 bag', 'Rs 360'),
              const Divider(height: 18),
              _BillRow('Milk 500ml', '2 pkt', 'Rs 64'),
              const Divider(height: 18),
              _BillRow('Toor Dal', '1 kg', 'Rs 165'),
              const Divider(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Text(
                    'Rs 589',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: () => context.go('/billing/stall-sale'),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Open full counter'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/voice-billing'),
              icon: const Icon(Icons.mic_rounded),
              label: const Text('Voice bill'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/printer-setup'),
              icon: const Icon(Icons.print_rounded),
              label: const Text('Print'),
            ),
          ],
        ),
      ],
    );
  }
}

class _BillRow extends StatelessWidget {
  const _BillRow(this.item, this.qty, this.amount);

  final String item;
  final String qty;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            item,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(child: Text(qty, textAlign: TextAlign.center)),
        Expanded(
          child: Text(
            amount,
            textAlign: TextAlign.end,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
