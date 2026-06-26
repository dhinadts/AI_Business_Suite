import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/common_widgets.dart';
import '../../auth/providers/auth_provider.dart';

class BusinessClassificationResultScreen extends ConsumerWidget {
  const BusinessClassificationResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authProvider).session;
    final company = session?.company;
    final message = switch (company?.classification) {
      'NORMAL_GROCERY_STORE' =>
        'Simple store mode enabled. We will show billing, stock, customers, expenses, and daily sales first.',
      'SMALL_BUSINESS' =>
        'MSME basic mode enabled. Your dashboard includes billing, GST, accounting, inventory, CRM, and reports.',
      'MEDIUM_BUSINESS' =>
        'Growth mode enabled. Your dashboard includes team workflows, purchase, HRMS, advanced inventory, and AI insights.',
      'LARGE_BUSINESS' =>
        'Enterprise mode enabled. Your dashboard includes multi-branch control, approvals, analytics, compliance, and department views.',
      _ => 'Your business dashboard has been configured.',
    };
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: FormSectionCard(
                title: 'Business classification complete',
                trailing: StatusChip(company?.uiPreset ?? 'Preset'),
                children: [
                  EmptyState(
                    title:
                        'Your business is configured as ${company?.friendlyClassification ?? 'Business'}',
                    message: message,
                    icon: Icons.verified_rounded,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryButton(
                      label: 'Continue to dashboard',
                      icon: Icons.dashboard_rounded,
                      onPressed: () {
                        ref.read(authProvider.notifier).consumeSignupFlag();
                        context.go('/dashboard');
                      },
                      accent: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
