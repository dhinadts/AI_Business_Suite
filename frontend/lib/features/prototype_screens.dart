import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/breakpoints.dart';
import '../app/business_profile.dart';
import '../app/providers.dart';
import '../app/theme.dart';
import '../core/constants/assets.dart';
import '../core/layout/responsive_scaffold.dart';
import '../core/models/association_models.dart';
import '../core/mock_data/mock_data.dart';
import '../core/widgets/brand_logo.dart';
import '../core/widgets/common_widgets.dart';
import 'associations/providers/associations_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.navy, AppColors.navySoft],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Image.asset(
                  AppAssets.logo,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'AI Business Suite',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'DHINADTS IT SOLUTIONS AND SUPPORT',
                style: TextStyle(color: Colors.white70, letterSpacing: 1),
              ),
              const SizedBox(height: 40),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.orange,
                ),
                onPressed: () => context.go('/login'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Launch prototype'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.signup = false});

  final bool signup;

  @override
  Widget build(BuildContext context) {
    final desktop = Breakpoints.isDesktop(context);
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (desktop)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: AppColors.navy,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        AppAssets.brandImage,
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.42),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(40),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Enterprise controls, AI workflows, and MSME-ready business clarity.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const BrandLogo(),
                            const SizedBox(height: 28),
                            Text(
                              signup ? 'Create workspace' : 'Welcome back',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 20),
                            if (signup)
                              const AppTextField(
                                label: 'Full name',
                                icon: Icons.person_rounded,
                              ),
                            if (signup) const SizedBox(height: 14),
                            const AppTextField(
                              label: 'Email',
                              icon: Icons.email_rounded,
                            ),
                            const SizedBox(height: 14),
                            const AppTextField(
                              label: 'Password',
                              icon: Icons.lock_rounded,
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              label: signup ? 'Continue onboarding' : 'Login',
                              icon: Icons.login_rounded,
                              onPressed: () => context.go(
                                signup ? '/onboarding' : '/dashboard',
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.go(signup ? '/login' : '/signup'),
                              child: Text(
                                signup
                                    ? 'Already have an account? Login'
                                    : 'New workspace? Sign up',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const BrandLogo()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: FormSectionCard(
              title: 'Company onboarding',
              children: [
                const Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 400,
                      child: AppTextField(
                        label: 'Business name',
                        icon: Icons.business_rounded,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: AppTextField(
                        label: 'Industry',
                        icon: Icons.category_rounded,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: AppTextField(
                        label: 'GSTIN placeholder',
                        icon: Icons.verified_rounded,
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      child: AppTextField(
                        label: 'City',
                        icon: Icons.location_city_rounded,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                PrimaryButton(
                  label: 'Open dashboard',
                  icon: Icons.dashboard_rounded,
                  onPressed: () => context.go('/dashboard'),
                  accent: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(businessProfileProvider);
    return AppScaffold(
      title: Breakpoints.isMobile(context)
          ? profile.title
          : profile.isGrocery
          ? 'Store Dashboard'
          : 'ERP Dashboard',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: profile.dashboardTitle,
            subtitle: profile.dashboardSubtitle,
          ),
          MetricGrid(children: _metricsForProfile(profile)),
          const SizedBox(height: 20),
          if (Breakpoints.isDesktop(context))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _DashboardMainTables(profile: profile),
                ),
                const SizedBox(width: 20),
                if (profile.showAi)
                  const Expanded(child: _AiSidePanel())
                else
                  Expanded(child: _SimpleBuildPanel(profile: profile)),
              ],
            )
          else
            Column(
              children: [
                _DashboardMainTables(profile: profile),
                const SizedBox(height: 16),
                if (profile.showAi)
                  const _AiSidePanel()
                else
                  _SimpleBuildPanel(profile: profile),
              ],
            ),
        ],
      ),
    );
  }
}

class _DashboardMainTables extends StatelessWidget {
  const _DashboardMainTables({required this.profile});

  final BusinessProfile profile;

  @override
  Widget build(BuildContext context) {
    if (profile.isGrocery) {
      return Column(
        children: [
          DataTableCard(
            title: 'Today sales counter',
            trailing: TextButton(
              onPressed: () => context.go('/billing/create'),
              child: const Text('New bill'),
            ),
            columns: const [
              DataColumn(label: Text('Bill')),
              DataColumn(label: Text('Items')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Mode')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('BILL-221')),
                  DataCell(Text('Rice, Milk, Soap')),
                  DataCell(Text('₹842')),
                  DataCell(StatusChip('Cash')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('BILL-220')),
                  DataCell(Text('Snacks, Oil')),
                  DataCell(Text('₹520')),
                  DataCell(StatusChip('UPI')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('BILL-219')),
                  DataCell(Text('Bread, Eggs')),
                  DataCell(Text('₹186')),
                  DataCell(StatusChip('Cash')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ModuleGrid(
            modules: [
              ModuleCard(
                title: 'Manual billing',
                subtitle: 'Fast item entry for counter sales',
                icon: Icons.point_of_sale_rounded,
                onTap: () => context.go('/billing/create'),
              ),
              ModuleCard(
                title: 'Voice billing',
                subtitle: 'Speak product names and quantities',
                icon: Icons.mic_rounded,
                onTap: () => context.go('/voice-billing'),
              ),
              ModuleCard(
                title: 'Store inventory',
                subtitle: 'Stock, low-stock, and reorder list',
                icon: Icons.inventory_2_rounded,
                onTap: () => context.go('/inventory'),
              ),
              ModuleCard(
                title: 'Daily report',
                subtitle: 'Simple sales and stock summary',
                icon: Icons.bar_chart_rounded,
                onTap: () => context.go('/reports'),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: [
        DataTableCard(
          title: 'Recent invoices',
          trailing: TextButton(
            onPressed: () => context.go('/billing/invoices'),
            child: const Text('View all'),
          ),
          columns: const [
            DataColumn(label: Text('Invoice')),
            DataColumn(label: Text('Customer')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Status')),
          ],
          rows: [
            for (final invoice in invoices)
              DataRow(
                cells: [
                  DataCell(Text(invoice.number)),
                  DataCell(Text(invoice.customer)),
                  DataCell(Text('₹${invoice.amount.toStringAsFixed(0)}')),
                  DataCell(StatusChip(invoice.status)),
                ],
              ),
          ],
        ),
        const SizedBox(height: 16),
        ModuleGrid(
          modules: [
            ModuleCard(
              title: 'Create invoice',
              subtitle: 'Full-screen invoice builder',
              icon: Icons.add_card_rounded,
              onTap: () => context.go('/billing/create'),
            ),
            if (profile.showOcr)
              ModuleCard(
                title: 'OCR upload',
                subtitle: 'Scan bills and receipts',
                icon: Icons.document_scanner_rounded,
                onTap: () => context.go('/ocr-upload'),
              ),
            if (profile.showAi)
              ModuleCard(
                title: 'Voice billing',
                subtitle: 'Speak items into a draft',
                icon: Icons.mic_rounded,
                onTap: () => context.go('/voice-billing'),
              ),
            ModuleCard(
              title: 'GST review',
              subtitle: 'Review outward supplies',
              icon: Icons.fact_check_rounded,
              onTap: () => context.go('/gst/gstr1-review'),
            ),
          ],
        ),
      ],
    );
  }
}

class _AiSidePanel extends StatelessWidget {
  const _AiSidePanel();

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: 'AI assistant',
      children: [
        Image.asset(
          AppAssets.aiImage,
          height: 150,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 14),
        AIQuickActionCard(
          title: 'Summarize today',
          subtitle: 'Revenue, dues, low stock, GST readiness',
          onTap: () => context.go('/ai-assistant'),
        ),
        const SizedBox(height: 10),
        AIQuickActionCard(
          title: 'Find billing risks',
          subtitle: 'Spot overdue and draft invoices',
          onTap: () => context.go('/reports/profit-loss'),
        ),
      ],
    );
  }
}

class _SimpleBuildPanel extends StatelessWidget {
  const _SimpleBuildPanel({required this.profile});

  final BusinessProfile profile;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: 'Build focus',
      children: [
        EmptyState(
          title: profile.title,
          message: profile.isGrocery
              ? 'This build keeps the app simple: manual billing, voice billing, stock, and daily reports.'
              : 'This build keeps the ERP focused on the core modules needed by a small registered company.',
          icon: profile.isGrocery
              ? Icons.storefront_rounded
              : Icons.business_center_rounded,
        ),
      ],
    );
  }
}

List<Widget> _metricsForProfile(BusinessProfile profile) {
  if (profile.isGrocery) {
    return const [
      StatCard(
        title: 'Today Sales',
        value: '₹42.8K',
        delta: '+8%',
        icon: Icons.point_of_sale_rounded,
        chartValues: [22, 26, 29, 31, 36, 42.8],
      ),
      StatCard(
        title: 'Bills Created',
        value: '126',
        delta: '+14',
        icon: Icons.receipt_long_rounded,
        chartValues: [78, 82, 91, 96, 112, 126],
      ),
      StatCard(
        title: 'Low Stock Items',
        value: '18',
        delta: 'Low',
        icon: Icons.inventory_rounded,
        chartValues: [34, 30, 28, 25, 21, 18],
      ),
      StatCard(
        title: 'UPI Share',
        value: '64%',
        delta: '+6%',
        icon: Icons.qr_code_rounded,
        chartValues: [41, 46, 50, 55, 58, 64],
      ),
    ];
  }
  if (profile == BusinessProfile.smallRegistered) {
    return const [
      StatCard(
        title: 'Monthly Revenue',
        value: '₹4.6L',
        delta: '+6%',
        icon: Icons.trending_up_rounded,
        chartValues: [2.9, 3.1, 3.4, 3.9, 4.2, 4.6],
      ),
      StatCard(
        title: 'Pending Bills',
        value: '₹82K',
        delta: 'Pending',
        icon: Icons.receipt_long_rounded,
        chartValues: [125, 116, 108, 99, 91, 82],
      ),
      StatCard(
        title: 'Stock Alerts',
        value: '7',
        delta: 'Low',
        icon: Icons.inventory_rounded,
        chartValues: [16, 14, 13, 10, 9, 7],
      ),
      StatCard(
        title: 'GST Ready',
        value: '88%',
        delta: '+3 docs',
        icon: Icons.verified_rounded,
        chartValues: [64, 70, 73, 79, 84, 88],
      ),
    ];
  }
  if (profile == BusinessProfile.largeRegistered) {
    return const [
      StatCard(
        title: 'Group Revenue',
        value: '₹2.8Cr',
        delta: '+18%',
        icon: Icons.trending_up_rounded,
        chartValues: [1.5, 1.7, 1.9, 2.2, 2.5, 2.8],
      ),
      StatCard(
        title: 'Receivables',
        value: '₹42L',
        delta: '-7%',
        icon: Icons.account_balance_wallet_rounded,
        chartValues: [68, 62, 57, 51, 46, 42],
      ),
      StatCard(
        title: 'Inventory Value',
        value: '₹1.2Cr',
        delta: '+11%',
        icon: Icons.inventory_2_rounded,
        chartValues: [0.72, 0.8, 0.87, 0.96, 1.08, 1.2],
      ),
      StatCard(
        title: 'Compliance Score',
        value: '97%',
        delta: '+9 docs',
        icon: Icons.verified_rounded,
        chartValues: [76, 81, 85, 90, 94, 97],
      ),
    ];
  }
  return [
    for (final metric in reportMetrics)
      StatCard(
        title: metric.label,
        value: metric.value,
        delta: metric.delta,
        icon: Icons.trending_up_rounded,
        chartValues: metric.chartValues,
      ),
  ];
}

class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(businessProfileProvider);
    return AppScaffold(
      title: profile.isGrocery ? 'Manual Billing' : 'Billing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: profile.isGrocery
                ? 'Simple counter billing'
                : 'Billing workspace',
            subtitle: profile.isGrocery
                ? 'Create quick grocery and departmental-store bills without ERP complexity.'
                : 'Invoice creation, previews, payments, and customer billing status.',
          ),
          ModuleGrid(
            modules: [
              ModuleCard(
                title: profile.isGrocery ? 'Today bills' : 'Invoice list',
                subtitle: profile.isGrocery
                    ? 'View counter sales'
                    : 'Browse all customer invoices',
                icon: Icons.list_alt_rounded,
                onTap: () => context.go('/billing/invoices'),
              ),
              ModuleCard(
                title: profile.isGrocery ? 'Sale counter' : 'Create invoice',
                subtitle: profile.isGrocery
                    ? 'Fast grocery billing with stock deduction'
                    : 'Build a new invoice draft',
                icon: profile.isGrocery
                    ? Icons.point_of_sale_rounded
                    : Icons.add_card_rounded,
                onTap: () => context.go(
                  profile.isGrocery ? '/billing/stall-sale' : '/billing/create',
                ),
              ),
              ModuleCard(
                title: profile.isGrocery ? 'Voice bill' : 'Invoice preview',
                subtitle: profile.isGrocery
                    ? 'Speak a grocery bill'
                    : 'Investor-ready print preview',
                icon: profile.isGrocery
                    ? Icons.mic_rounded
                    : Icons.visibility_rounded,
                onTap: () => context.go(
                  profile.isGrocery
                      ? '/voice-billing'
                      : '/billing/invoice-preview',
                ),
              ),
              if (profile.isGrocery)
                ModuleCard(
                  title: 'Scan supplier bill',
                  subtitle: 'Add invoice items to store room stock',
                  icon: Icons.document_scanner_rounded,
                  onTap: () => context.go('/ocr-upload'),
                ),
              if (profile.isGrocery)
                ModuleCard(
                  title: 'Printer setup',
                  subtitle: 'Wi-Fi, Bluetooth, and 58mm receipt test',
                  icon: Icons.print_rounded,
                  onTap: () => context.go('/printer-setup'),
                ),
              if (profile.isGrocery)
                ModuleCard(
                  title: 'Translator',
                  subtitle: 'Translate item names and voice commands',
                  icon: Icons.translate_rounded,
                  onTap: () => context.go('/translator'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class GrocerySaleScreen extends StatelessWidget {
  const GrocerySaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 880;
    final saleEntry = FormSectionCard(
      title: 'Grocery sale counter',
      trailing: const StatusChip('Stock auto update'),
      children: [
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 260,
              child: AppTextField(
                label: 'Scan barcode or item name',
                icon: Icons.qr_code_scanner_rounded,
              ),
            ),
            SizedBox(width: 132, child: AppTextField(label: 'Qty')),
            SizedBox(width: 132, child: AppTextField(label: 'Unit')),
            SizedBox(width: 148, child: AppTextField(label: 'Rate')),
          ],
        ),
        const SizedBox(height: 14),
        const _ChipRow(
          title: 'Common units',
          chips: ['kg', 'gram', 'litre', 'ml', 'packet', 'piece', 'dozen'],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: 'Add item',
              icon: Icons.add_rounded,
              onPressed: () {},
              accent: true,
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/voice-billing'),
              icon: const Icon(Icons.mic_rounded),
              label: const Text('Use voice'),
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/translator'),
              icon: const Icon(Icons.translate_rounded),
              label: const Text('Translate item'),
            ),
          ],
        ),
      ],
    );
    final bill = FormSectionCard(
      title: 'Current customer bill',
      trailing: const StatusChip('Cash / UPI'),
      children: [
        DataTableCard(
          title: 'Items',
          columns: const [
            DataColumn(label: Text('Item')),
            DataColumn(label: Text('Qty')),
            DataColumn(label: Text('Total')),
          ],
          rows: const [
            DataRow(
              cells: [
                DataCell(Text('Rice 5kg')),
                DataCell(Text('1 bag')),
                DataCell(Text('₹360')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Milk 500ml')),
                DataCell(Text('2 pkt')),
                DataCell(Text('₹64')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('Toor Dal')),
                DataCell(Text('1 kg')),
                DataCell(Text('₹165')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        const _StockFlowNote(),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.end,
          children: [
            OutlinedButton.icon(
              onPressed: () => context.go('/printer-setup'),
              icon: const Icon(Icons.print_rounded),
              label: const Text('Print test'),
            ),
            PrimaryButton(
              label: 'Save & print ₹589',
              icon: Icons.receipt_long_rounded,
              onPressed: () {},
              accent: true,
            ),
          ],
        ),
      ],
    );
    return AppScaffold(
      title: 'Sale Counter',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Fast grocery billing for small stalls',
            subtitle:
                'Manual entry, barcode scan, multilingual voice entry, UPI/cash payment, and automatic stock deduction from every bill.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: saleEntry),
                const SizedBox(width: 16),
                Expanded(child: bill),
              ],
            )
          else
            Column(children: [saleEntry, const SizedBox(height: 16), bill]),
        ],
      ),
    );
  }
}

class InvoiceListScreen extends ConsumerWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: 'Invoices',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchFilterBar(
            hint: 'Search invoices',
            actionLabel: 'Create invoice',
            onAction: () => context.go('/billing/create'),
          ),
          const SizedBox(height: 16),
          DataTableCard(
            title: 'Invoice register',
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Status')),
            ],
            rows: [
              for (final invoice in invoices)
                DataRow(
                  onSelectChanged: (_) {
                    ref.read(selectedInvoiceProvider.notifier).state = invoice;
                    context.go('/billing/invoice-preview');
                  },
                  cells: [
                    DataCell(Text(invoice.number)),
                    DataCell(Text(invoice.customer)),
                    DataCell(Text(invoice.date)),
                    DataCell(Text('₹${invoice.amount.toStringAsFixed(0)}')),
                    DataCell(StatusChip(invoice.status)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class CreateInvoiceScreen extends ConsumerWidget {
  const CreateInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(businessProfileProvider);
    if (profile.isGrocery) {
      return AppScaffold(
        title: 'Manual Bill',
        child: Column(
          children: [
            FormSectionCard(
              title: 'Counter sale',
              children: const [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 280,
                      child: AppTextField(
                        label: 'Customer name optional',
                        icon: Icons.person_rounded,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: AppTextField(
                        label: 'Mobile optional',
                        icon: Icons.phone_rounded,
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      child: AppTextField(
                        label: 'Payment mode',
                        icon: Icons.payments_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormSectionCard(
              title: 'Add grocery items',
              children: [
                const Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: 300,
                      child: AppTextField(
                        label: 'Item name or barcode',
                        icon: Icons.qr_code_scanner_rounded,
                      ),
                    ),
                    SizedBox(width: 120, child: AppTextField(label: 'Qty')),
                    SizedBox(width: 140, child: AppTextField(label: 'MRP')),
                    SizedBox(
                      width: 140,
                      child: AppTextField(label: 'Discount'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                DataTableCard(
                  title: 'Current bill',
                  columns: const [
                    DataColumn(label: Text('Item')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Amount')),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(Text('Rice 5kg')),
                        DataCell(Text('1')),
                        DataCell(Text('₹360')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('Milk 1L')),
                        DataCell(Text('2')),
                        DataCell(Text('₹128')),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text('Soap')),
                        DataCell(Text('3')),
                        DataCell(Text('₹150')),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.centerRight,
                  child: PrimaryButton(
                    label: 'Preview bill',
                    icon: Icons.receipt_long_rounded,
                    onPressed: () => context.go('/billing/invoice-preview'),
                    accent: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AppScaffold(
      title: 'Create Invoice',
      child: Column(
        children: [
          FormSectionCard(
            title: 'Customer and invoice details',
            children: const [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 340,
                    child: AppTextField(
                      label: 'Customer',
                      icon: Icons.person_rounded,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: AppTextField(
                      label: 'Invoice date',
                      icon: Icons.calendar_today_rounded,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: AppTextField(
                      label: 'Due date',
                      icon: Icons.event_available_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          FormSectionCard(
            title: 'Line items',
            children: [
              const Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 320,
                    child: AppTextField(
                      label: 'Item name',
                      icon: Icons.sell_rounded,
                    ),
                  ),
                  SizedBox(width: 140, child: AppTextField(label: 'Qty')),
                  SizedBox(width: 180, child: AppTextField(label: 'Rate')),
                  SizedBox(width: 180, child: AppTextField(label: 'Tax')),
                ],
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  label: 'Preview invoice',
                  icon: Icons.visibility_rounded,
                  onPressed: () => context.go('/billing/invoice-preview'),
                  accent: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InvoicePreviewScreen extends ConsumerWidget {
  const InvoicePreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoice = ref.watch(selectedInvoiceProvider);
    return AppScaffold(
      title: 'Invoice Preview',
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 840),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandLogo(),
                  const Divider(height: 34),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          invoice.number,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                      ),
                      StatusChip(invoice.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Bill to: ${invoice.customer}'),
                  Text('Date: ${invoice.date}'),
                  const SizedBox(height: 24),
                  DataTableCard(
                    title: 'Items',
                    columns: const [
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Qty')),
                      DataColumn(label: Text('Total')),
                    ],
                    rows: const [
                      DataRow(
                        cells: [
                          DataCell(Text('AI Business Suite License')),
                          DataCell(Text('1')),
                          DataCell(Text('₹24,000')),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(Text('Implementation Support')),
                          DataCell(Text('1')),
                          DataCell(Text('₹18,000')),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Grand total: ₹${invoice.amount.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
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

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key, this.detail = false});

  final bool detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(selectedProductProvider);
    final profile = ref.watch(businessProfileProvider);
    if (detail) return ProductDetailScreen(productName: product.name);
    return AppScaffold(
      title: profile.isGrocery ? 'Store Inventory' : 'Inventory',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: profile.isGrocery
                ? 'Shelf stock and reorder list'
                : 'Inventory management',
            subtitle: profile.isGrocery
                ? 'Track grocery items, units, sale deduction, scanned supplier bills, store room stock, and low-stock alerts.'
                : 'Track products, SKU, stock availability, and product details.',
          ),
          SearchFilterBar(
            hint: profile.isGrocery
                ? 'Search item or barcode'
                : 'Search products',
            actionLabel: profile.isGrocery ? 'Add item' : 'Add product',
            onAction: () {},
          ),
          const SizedBox(height: 16),
          if (profile.isGrocery) ...[
            ModuleGrid(
              modules: [
                ModuleCard(
                  title: 'Stock intake',
                  subtitle: 'Add supplier invoice items by unit',
                  icon: Icons.inventory_rounded,
                  onTap: () => context.go('/inventory/stock-intake'),
                ),
                ModuleCard(
                  title: 'Scan invoice',
                  subtitle: 'OCR supplier bill into inventory',
                  icon: Icons.document_scanner_rounded,
                  onTap: () => context.go('/ocr-upload'),
                ),
                ModuleCard(
                  title: 'Sale deduction',
                  subtitle: 'Every saved bill reduces shelf stock',
                  icon: Icons.point_of_sale_rounded,
                  onTap: () => context.go('/billing/stall-sale'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          Breakpoints.isTablet(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _ProductList(ref: ref)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ProductDetailCard(productName: product.name),
                    ),
                  ],
                )
              : _ProductList(ref: ref),
        ],
      ),
    );
  }
}

class StockIntakeScreen extends StatelessWidget {
  const StockIntakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final intakeForm = FormSectionCard(
      title: 'Supplier invoice stock intake',
      trailing: const StatusChip('Store room'),
      children: const [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 260,
              child: AppTextField(
                label: 'Supplier name',
                icon: Icons.store_mall_directory_rounded,
              ),
            ),
            SizedBox(
              width: 180,
              child: AppTextField(
                label: 'Invoice number',
                icon: Icons.receipt_long_rounded,
              ),
            ),
            SizedBox(
              width: 160,
              child: AppTextField(
                label: 'Date',
                icon: Icons.calendar_today_rounded,
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 260,
              child: AppTextField(
                label: 'Product from invoice',
                icon: Icons.inventory_2_rounded,
              ),
            ),
            SizedBox(width: 120, child: AppTextField(label: 'Qty')),
            SizedBox(width: 120, child: AppTextField(label: 'Unit')),
            SizedBox(width: 140, child: AppTextField(label: 'Purchase rate')),
            SizedBox(width: 140, child: AppTextField(label: 'MRP')),
          ],
        ),
      ],
    );
    final flow = FormSectionCard(
      title: 'How stock updates',
      children: [
        const _FlowStep(
          number: '1',
          title: 'Scan or enter supplier bill',
          subtitle:
              'Products, units, MRP, GST, and purchase rate are captured.',
        ),
        const _FlowStep(
          number: '2',
          title: 'Add to store room',
          subtitle:
              'Bulk stock increases by unit: kg, gram, litre, ml, packet, or piece.',
        ),
        const _FlowStep(
          number: '3',
          title: 'Move to sale shelf',
          subtitle:
              'Shelf quantity is available for counter and voice billing.',
        ),
        const _FlowStep(
          number: '4',
          title: 'Deduct on every bill',
          subtitle:
              'Saved customer bills reduce stock and trigger low-stock alerts.',
        ),
        const SizedBox(height: 12),
        PrimaryButton(
          label: 'Scan supplier invoice',
          icon: Icons.document_scanner_rounded,
          onPressed: () => context.go('/ocr-upload'),
          accent: true,
        ),
      ],
    );
    return AppScaffold(
      title: 'Stock Intake',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Inventory from supplier bills',
            subtitle:
                'Add purchase invoice products into store room stock, then sell by exact unit at the counter.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: intakeForm),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: flow),
              ],
            )
          else
            Column(children: [intakeForm, const SizedBox(height: 16), flow]),
        ],
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DataTableCard(
      title: 'Product catalog',
      columns: const [
        DataColumn(label: Text('Product')),
        DataColumn(label: Text('SKU')),
        DataColumn(label: Text('Stock')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Status')),
      ],
      rows: [
        for (final product in products)
          DataRow(
            onSelectChanged: (_) {
              ref.read(selectedProductProvider.notifier).state = product;
              context.go('/inventory/product-detail');
            },
            cells: [
              DataCell(Text(product.name)),
              DataCell(Text(product.sku)),
              DataCell(Text('${product.stock}')),
              DataCell(Text('₹${product.price.toStringAsFixed(0)}')),
              DataCell(StatusChip(product.status)),
            ],
          ),
      ],
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.productName});

  final String? productName;

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: 'Product Detail',
    child: ProductDetailCard(productName: productName ?? products.first.name),
  );
}

class ProductDetailCard extends StatelessWidget {
  const ProductDetailCard({super.key, required this.productName});

  final String productName;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: productName,
      children: const [
        ListTile(
          leading: Icon(Icons.qr_code_2_rounded),
          title: Text('SKU'),
          trailing: Text('POS-CLD-01'),
        ),
        ListTile(
          leading: Icon(Icons.inventory_rounded),
          title: Text('Available stock'),
          trailing: Text('42 units'),
        ),
        ListTile(
          leading: Icon(Icons.currency_rupee_rounded),
          title: Text('Selling price'),
          trailing: Text('₹12,999'),
        ),
        EmptyState(
          title: 'Stock forecast',
          message:
              'AI reorder recommendations will appear here in a future integration.',
          icon: Icons.insights_rounded,
        ),
      ],
    );
  }
}

class CrmScreen extends ConsumerWidget {
  const CrmScreen({super.key, this.profile = false});

  final bool profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (profile) return const CustomerProfileScreen();
    return AppScaffold(
      title: 'CRM',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Customer relationship hub',
            subtitle: 'Track leads, customers, follow-ups, and receivables.',
          ),
          ModuleCard(
            title: 'Customer list',
            subtitle: 'Open customer records',
            icon: Icons.people_alt_rounded,
            onTap: () => context.go('/crm/customers'),
          ),
          const SizedBox(height: 16),
          CustomerList(ref: ref),
        ],
      ),
    );
  }
}

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AppScaffold(
    title: 'Customers',
    child: CustomerList(ref: ref),
  );
}

class CustomerList extends StatelessWidget {
  const CustomerList({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return DataTableCard(
      title: 'Customer list',
      columns: const [
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Company')),
        DataColumn(label: Text('Phone')),
        DataColumn(label: Text('Revenue')),
        DataColumn(label: Text('Status')),
      ],
      rows: [
        for (final customer in customers)
          DataRow(
            onSelectChanged: (_) {
              ref.read(selectedCustomerProvider.notifier).state = customer;
              context.go('/crm/customer-profile');
            },
            cells: [
              DataCell(Text(customer.name)),
              DataCell(Text(customer.company)),
              DataCell(Text(customer.phone)),
              DataCell(Text('₹${customer.revenue.toStringAsFixed(0)}')),
              DataCell(StatusChip(customer.status)),
            ],
          ),
      ],
    );
  }
}

class CustomerProfileScreen extends ConsumerWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(selectedCustomerProvider);
    return AppScaffold(
      title: 'Customer Profile',
      child: FormSectionCard(
        title: customer.company,
        children: [
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: Text(customer.name),
            subtitle: Text(customer.phone),
            trailing: StatusChip(customer.status),
          ),
          ListTile(
            leading: const Icon(Icons.currency_rupee_rounded),
            title: const Text('Lifetime revenue'),
            trailing: Text('₹${customer.revenue.toStringAsFixed(0)}'),
          ),
          const ListTile(
            leading: Icon(Icons.task_alt_rounded),
            title: Text('Next action'),
            subtitle: Text('Send renewal proposal and payment reminder'),
          ),
          AIQuickActionCard(
            title: 'Draft follow-up',
            subtitle: 'Generate a polite WhatsApp-ready message',
            onTap: () => context.go('/ai-assistant'),
          ),
        ],
      ),
    );
  }
}

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Accounting',
      child: Column(
        children: [
          const ScreenHeader(
            title: 'Accounting dashboard',
            subtitle:
                'Cash flow, ledgers, expense placeholders, and reconciliation views.',
          ),
          MetricGrid(
            children: const [
              StatCard(
                title: 'Cash in bank',
                value: '₹12.6L',
                delta: '+7.1%',
                icon: Icons.account_balance_rounded,
                chartValues: [7.8, 8.6, 9.4, 10.2, 11.3, 12.6],
              ),
              StatCard(
                title: 'Receivables',
                value: '₹3.2L',
                delta: 'Pending',
                icon: Icons.call_received_rounded,
                chartValues: [4.5, 4.2, 3.9, 3.6, 3.4, 3.2],
              ),
              StatCard(
                title: 'Payables',
                value: '₹1.8L',
                delta: 'Draft',
                icon: Icons.call_made_rounded,
                chartValues: [1.1, 1.2, 1.3, 1.5, 1.7, 1.8],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const EmptyState(
            title: 'Ledger automation placeholder',
            message:
                'No accounting rules are connected in this UI-only prototype.',
            icon: Icons.account_tree_rounded,
          ),
        ],
      ),
    );
  }
}

class GstScreen extends StatelessWidget {
  const GstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'GST Compliance',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'GST compliance hub',
            subtitle:
                'Review returns, spot missing documents, and simulate filing flow.',
          ),
          DataTableCard(
            title: 'GST returns',
            trailing: PrimaryButton(
              label: 'File GST',
              icon: Icons.cloud_upload_rounded,
              onPressed: () => context.go('/gst/filing-success'),
              accent: true,
            ),
            columns: const [
              DataColumn(label: Text('Period')),
              DataColumn(label: Text('Return')),
              DataColumn(label: Text('Taxable value')),
              DataColumn(label: Text('Status')),
            ],
            rows: [
              for (final gst in gstReturns)
                DataRow(
                  cells: [
                    DataCell(Text(gst.period)),
                    DataCell(Text(gst.type)),
                    DataCell(Text('₹${gst.taxableValue.toStringAsFixed(0)}')),
                    DataCell(StatusChip(gst.status)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          ModuleCard(
            title: 'GSTR-1 review',
            subtitle: 'Verify outward supplies before filing',
            icon: Icons.fact_check_rounded,
            onTap: () => context.go('/gst/gstr1-review'),
          ),
        ],
      ),
    );
  }
}

class GstrReviewScreen extends StatelessWidget {
  const GstrReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'GSTR-1 Review',
      child: Column(
        children: [
          DataTableCard(
            title: 'Outward supply review',
            columns: const [
              DataColumn(label: Text('Invoice')),
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Taxable')),
              DataColumn(label: Text('Status')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('INV-1048')),
                  DataCell(Text('Rao Textiles')),
                  DataCell(Text('₹41,200')),
                  DataCell(StatusChip('Matched')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('INV-1047')),
                  DataCell(Text('Shah Hardware')),
                  DataCell(Text('₹66,270')),
                  DataCell(StatusChip('Review')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'File GST',
              icon: Icons.verified_rounded,
              onPressed: () => context.go('/gst/filing-success'),
              accent: true,
            ),
          ),
        ],
      ),
    );
  }
}

class GstSuccessScreen extends StatelessWidget {
  const GstSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Filing Success',
      child: Center(
        child: EmptyState(
          title: 'GST filing simulated',
          message: 'GSTR-1 for June 2026 is marked filed in dummy UI data.',
          icon: Icons.check_circle_rounded,
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Reports',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Reports dashboard',
            subtitle:
                'Executive metrics, financial summaries, and visual placeholders.',
          ),
          MetricGrid(
            children: [
              for (final metric in reportMetrics)
                StatCard(
                  title: metric.label,
                  value: metric.value,
                  delta: metric.delta,
                  icon: Icons.query_stats_rounded,
                  chartValues: metric.chartValues,
                ),
            ],
          ),
          const SizedBox(height: 16),
          ModuleCard(
            title: 'Profit & Loss detail',
            subtitle: 'Open a detailed P&L statement',
            icon: Icons.stacked_line_chart_rounded,
            onTap: () => context.go('/reports/profit-loss'),
          ),
        ],
      ),
    );
  }
}

class ProfitLossScreen extends StatelessWidget {
  const ProfitLossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Profit & Loss',
      child: DataTableCard(
        title: 'Profit & loss detail',
        columns: const [
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Current month')),
          DataColumn(label: Text('Previous month')),
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(Text('Revenue')),
              DataCell(Text('₹18,40,000')),
              DataCell(Text('₹16,35,000')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Cost of goods')),
              DataCell(Text('₹8,10,000')),
              DataCell(Text('₹7,70,000')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Gross profit')),
              DataCell(Text('₹10,30,000')),
              DataCell(Text('₹8,65,000')),
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('Operating expenses')),
              DataCell(Text('₹3,20,000')),
              DataCell(Text('₹3,05,000')),
            ],
          ),
        ],
      ),
    );
  }
}

class AiAssistantScreen extends ConsumerWidget {
  const AiAssistantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(aiChatMessagesProvider);
    return AppScaffold(
      title: 'AI Assistant',
      child: Column(
        children: [
          for (final message in messages)
            Align(
              alignment: message.isAi
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 720),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: message.isAi
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : AppColors.navy,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.5),
                  ),
                ),
                child: Text(
                  message.message,
                  style: TextStyle(
                    color: message.isAi
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.white,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          FormSectionCard(
            title: 'Ask AI',
            children: [
              const AppTextField(
                label: 'Message',
                hint: 'Ask about invoices, GST, stock, or customers',
                icon: Icons.auto_awesome_rounded,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  label: 'Send',
                  icon: Icons.send_rounded,
                  onPressed: () {},
                  accent: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OcrUploadScreen extends StatelessWidget {
  const OcrUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 860;
    return AppScaffold(
      title: 'Scan Invoice',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Scan supplier invoice into inventory',
            subtitle:
                'Capture product names, packet sizes, quantities, MRP, purchase price, and GST from a paper bill or uploaded image.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ScanDropZone(
                    onStart: () => context.go('/ocr-scanning'),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(child: _ScanRulesCard()),
              ],
            )
          else
            Column(
              children: [
                _ScanDropZone(onStart: () => context.go('/ocr-scanning')),
                const SizedBox(height: 16),
                const _ScanRulesCard(),
              ],
            ),
        ],
      ),
    );
  }
}

class OcrScanningScreen extends StatelessWidget {
  const OcrScanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'OCR Scanning',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Review scanned stock items',
            subtitle:
                'Confirm extracted products before adding them to inventory and store room stock.',
          ),
          DataTableCard(
            title: 'Detected supplier invoice items',
            trailing: const StatusChip('94% confidence'),
            columns: const [
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Unit')),
              DataColumn(label: Text('MRP')),
              DataColumn(label: Text('Action')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('Rice Sona Masoori 5kg')),
                  DataCell(Text('12')),
                  DataCell(Text('bags')),
                  DataCell(Text('₹360')),
                  DataCell(StatusChip('Add')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Sunflower Oil 1L')),
                  DataCell(Text('24')),
                  DataCell(Text('bottles')),
                  DataCell(Text('₹142')),
                  DataCell(StatusChip('Add')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Toor Dal 1kg')),
                  DataCell(Text('18')),
                  DataCell(Text('packets')),
                  DataCell(Text('₹165')),
                  DataCell(StatusChip('Review')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          FormSectionCard(
            title: 'Inventory destination',
            children: [
              const _StockFlowNote(),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  PrimaryButton(
                    label: 'Add all to stock',
                    icon: Icons.inventory_rounded,
                    onPressed: () => context.go('/inventory'),
                    accent: true,
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/inventory/stock-intake'),
                    icon: const Icon(Icons.edit_note_rounded),
                    label: const Text('Edit stock intake'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VoiceBillingScreen extends ConsumerWidget {
  const VoiceBillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(businessProfileProvider);
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final voiceCard = FormSectionCard(
      title: profile.isGrocery
          ? 'Multilingual grocery voice billing'
          : 'Create invoice by voice',
      trailing: const StatusChip('Hindi + regional'),
      children: [
        const _ChipRow(
          title: 'Voice languages',
          chips: [
            'Hindi',
            'Tamil',
            'Telugu',
            'Kannada',
            'Malayalam',
            'Marathi',
            'Bengali',
            'Gujarati',
            'English',
          ],
        ),
        const SizedBox(height: 14),
        EmptyState(
          title: 'Ready to listen',
          message: profile.isGrocery
              ? 'Say: "do kilo chawal, ek litre oil, teen milk packet" or use your regional language.'
              : 'Speak customer and line items to simulate invoice capture.',
          icon: Icons.mic_rounded,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: profile.isGrocery
                  ? 'Start voice bill'
                  : 'Start voice billing',
              icon: Icons.mic_rounded,
              onPressed: () => context.go('/voice-billing/active'),
              accent: true,
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/translator'),
              icon: const Icon(Icons.translate_rounded),
              label: const Text('Open translator'),
            ),
          ],
        ),
      ],
    );
    const examples = FormSectionCard(
      title: 'Accepted grocery phrases',
      children: [
        _VoicePhrase(
          language: 'Hindi',
          phrase: 'do kilo chawal, ek tel',
          result: 'Rice 2kg, Oil 1L',
        ),
        _VoicePhrase(
          language: 'Tamil',
          phrase: 'rendu paal packet, oru arisi',
          result: 'Milk x2, Rice x1',
        ),
        _VoicePhrase(
          language: 'Telugu',
          phrase: 'rendu paalu, oka kilo pappu',
          result: 'Milk x2, Dal 1kg',
        ),
        _VoicePhrase(
          language: 'English',
          phrase: 'Add two milk, one bread, five kg rice',
          result: 'Milk x2, Bread x1, Rice 5kg',
        ),
      ],
    );
    return AppScaffold(
      title: profile.isGrocery ? 'Voice Bill' : 'Voice Billing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Voice billing for every device',
            subtitle:
                'Works as a PWA, web, tablet, and mobile counter flow with regional language grocery commands.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: voiceCard),
                const SizedBox(width: 16),
                const Expanded(child: examples),
              ],
            )
          else
            Column(children: [voiceCard, const SizedBox(height: 16), examples]),
        ],
      ),
    );
  }
}

class VoiceActiveScreen extends StatelessWidget {
  const VoiceActiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Listening',
      child: FormSectionCard(
        title: 'Active listening',
        children: [
          const Center(
            child: Icon(
              Icons.graphic_eq_rounded,
              size: 96,
              color: AppColors.orange,
            ),
          ),
          const EmptyState(
            title: 'Capturing grocery items',
            message: 'Do kilo chawal, ek litre oil, teen milk packet...',
            icon: Icons.hearing_rounded,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Review voice bill',
              icon: Icons.rate_review_rounded,
              onPressed: () => context.go('/voice-billing/review'),
              accent: true,
            ),
          ),
        ],
      ),
    );
  }
}

class VoiceReviewScreen extends StatelessWidget {
  const VoiceReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Voice Bill Review',
      child: Column(
        children: [
          DataTableCard(
            title: 'Captured grocery sale',
            columns: const [
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Qty')),
              DataColumn(label: Text('Rate')),
            ],
            rows: const [
              DataRow(
                cells: [
                  DataCell(Text('Rice Sona Masoori')),
                  DataCell(Text('2 kg')),
                  DataCell(Text('₹144')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Sunflower Oil')),
                  DataCell(Text('1 litre')),
                  DataCell(Text('₹142')),
                ],
              ),
              DataRow(
                cells: [
                  DataCell(Text('Milk packet')),
                  DataCell(Text('3')),
                  DataCell(Text('₹96')),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Create sale bill & reduce stock',
              icon: Icons.receipt_long_rounded,
              onPressed: () => context.go('/billing/stall-sale'),
            ),
          ),
        ],
      ),
    );
  }
}

class TranslatorToolScreen extends StatelessWidget {
  const TranslatorToolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    final input = FormSectionCard(
      title: 'Grocery language translator',
      trailing: const StatusChip('Voice support'),
      children: [
        const _ChipRow(
          title: 'Translate between',
          chips: [
            'Hindi',
            'Tamil',
            'Telugu',
            'Kannada',
            'Malayalam',
            'Marathi',
            'Bengali',
            'Gujarati',
            'English',
          ],
        ),
        const SizedBox(height: 14),
        const AppTextField(
          label: 'Customer phrase or product name',
          hint: 'Example: aadha kilo cheeni',
          icon: Icons.record_voice_over_rounded,
        ),
        const SizedBox(height: 12),
        const AppTextField(
          label: 'Translated billing item',
          hint: 'Sugar 500g',
          icon: Icons.translate_rounded,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: 'Use in voice bill',
              icon: Icons.mic_rounded,
              onPressed: () => context.go('/voice-billing'),
              accent: true,
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/billing/stall-sale'),
              icon: const Icon(Icons.point_of_sale_rounded),
              label: const Text('Use in sale'),
            ),
          ],
        ),
      ],
    );
    const glossary = FormSectionCard(
      title: 'Common grocery glossary',
      children: [
        _VoicePhrase(language: 'Hindi', phrase: 'chawal', result: 'Rice'),
        _VoicePhrase(language: 'Tamil', phrase: 'paal', result: 'Milk'),
        _VoicePhrase(language: 'Telugu', phrase: 'pappu', result: 'Dal'),
        _VoicePhrase(language: 'Kannada', phrase: 'enne', result: 'Oil'),
        _VoicePhrase(
          language: 'Malayalam',
          phrase: 'panchasara',
          result: 'Sugar',
        ),
      ],
    );
    return AppScaffold(
      title: 'Translator',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Multi-language translator for grocery billing',
            subtitle:
                'Convert regional spoken item names into billable products and units for low-literacy counters.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: input),
                const SizedBox(width: 16),
                const Expanded(child: glossary),
              ],
            )
          else
            Column(children: [input, const SizedBox(height: 16), glossary]),
        ],
      ),
    );
  }
}

class PrinterSetupScreen extends StatelessWidget {
  const PrinterSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    const printers = FormSectionCard(
      title: 'Receipt printer setup',
      trailing: StatusChip('58mm / 80mm'),
      children: [
        _PrinterStatusTile(
          title: 'Bluetooth printer',
          subtitle: 'MTP-II thermal printer nearby',
          status: 'Pair',
        ),
        _PrinterStatusTile(
          title: 'Wi-Fi printer',
          subtitle: '192.168.1.42 on store network',
          status: 'Connected',
        ),
        _PrinterStatusTile(
          title: 'USB / desktop printer',
          subtitle: 'Use browser print for web and PWA',
          status: 'Ready',
        ),
      ],
    );
    final testPrint = FormSectionCard(
      title: 'Billing print options',
      children: [
        const _ChipRow(
          title: 'Receipt format',
          chips: ['58mm', '80mm', 'A5 invoice', 'WhatsApp PDF'],
        ),
        const SizedBox(height: 14),
        const _StockFlowNote(),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            PrimaryButton(
              label: 'Print test bill',
              icon: Icons.print_rounded,
              onPressed: () {},
              accent: true,
            ),
            OutlinedButton.icon(
              onPressed: () => context.go('/billing/stall-sale'),
              icon: const Icon(Icons.point_of_sale_rounded),
              label: const Text('Open sale counter'),
            ),
          ],
        ),
      ],
    );
    return AppScaffold(
      title: 'Printer Setup',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Wi-Fi and Bluetooth billing printer',
            subtitle:
                'Set up low-cost thermal printing for mobile, tablet, desktop web, and PWA billing counters.',
          ),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: printers),
                const SizedBox(width: 16),
                Expanded(child: testPrint),
              ],
            )
          else
            Column(children: [printers, const SizedBox(height: 16), testPrint]),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Settings',
      child: ModuleGrid(
        modules: [
          ModuleCard(
            title: 'Team roles',
            subtitle: 'Permissions and staff access',
            icon: Icons.admin_panel_settings_rounded,
            onTap: () => context.go('/settings/team-roles'),
          ),
          ModuleCard(
            title: 'Add member',
            subtitle: 'Invite a team member',
            icon: Icons.person_add_alt_rounded,
            onTap: () => context.go('/settings/add-team-member'),
          ),
          ModuleCard(
            title: 'User management',
            subtitle: 'Manage users and status',
            icon: Icons.manage_accounts_rounded,
            onTap: () => context.go('/settings/users'),
          ),
          ModuleCard(
            title: 'Translator',
            subtitle: 'Regional grocery item translation',
            icon: Icons.translate_rounded,
            onTap: () => context.go('/translator'),
          ),
          ModuleCard(
            title: 'Printer setup',
            subtitle: 'Wi-Fi and Bluetooth billing printers',
            icon: Icons.print_rounded,
            onTap: () => context.go('/printer-setup'),
          ),
          ModuleCard(
            title: 'Profile',
            subtitle: 'Company and user profile',
            icon: Icons.badge_rounded,
            onTap: () => context.go('/profile'),
          ),
          ModuleCard(
            title: 'Subscription',
            subtitle: 'Pricing placeholder',
            icon: Icons.workspace_premium_rounded,
            onTap: () => context.go('/subscription'),
          ),
          ModuleCard(
            title: 'Help/support',
            subtitle: 'Support knowledge base',
            icon: Icons.support_agent_rounded,
            onTap: () => context.go('/help'),
          ),
        ],
      ),
    );
  }
}

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Subscription & Pricing',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenHeader(
            title: 'Subscription plans',
            subtitle:
                'Employee-based monthly plans with UI placeholders for UPI and bank-transfer auto renewal.',
          ),
          ResponsiveCardGrid(
            desktopColumns: 3,
            tabletColumns: 2,
            rowExtent: 238,
            children: const [
              _PlanCard(
                name: 'Starter',
                price: '₹399/month',
                employees: 'For less than 3 employees',
                description:
                    'Simple billing, inventory, reports, and basic settings.',
                icon: Icons.storefront_rounded,
              ),
              _PlanCard(
                name: 'Growth',
                price: '₹999/month',
                employees: 'For more than 5 employees',
                description:
                    'Billing, CRM, inventory, GST hub, reports, and team roles.',
                icon: Icons.business_center_rounded,
                highlighted: true,
              ),
              _PlanCard(
                name: 'Enterprise',
                price: '₹1499/month',
                employees: 'For more than 10 employees',
                description:
                    'Advanced ERP dashboard, accounting, AI assistant, OCR, and admin controls.',
                icon: Icons.domain_rounded,
              ),
            ],
          ),
          const SizedBox(height: 18),
          FormSectionCard(
            title: 'Auto-renewal setup',
            trailing: const StatusChip('UI only'),
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: 360,
                    child: _RenewalMethodCard(
                      title: 'UPI auto renewal',
                      subtitle:
                          'Show UPI mandate status, next renewal date, and virtual payment address.',
                      icon: Icons.qr_code_2_rounded,
                      chips: const ['UPI mandate', 'Monthly', 'Auto reminder'],
                    ),
                  ),
                  SizedBox(
                    width: 360,
                    child: _RenewalMethodCard(
                      title: 'Bank transfer renewal',
                      subtitle:
                          'Show bank transfer instructions, reference ID, and renewal confirmation status.',
                      icon: Icons.account_balance_rounded,
                      chips: const [
                        'NEFT/IMPS',
                        'Reference ID',
                        'Manual verify',
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              DataTableCard(
                title: 'Renewal preview',
                columns: const [
                  DataColumn(label: Text('Plan')),
                  DataColumn(label: Text('Employees')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Renewal mode')),
                  DataColumn(label: Text('Status')),
                ],
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(Text('Starter')),
                      DataCell(Text('< 3')),
                      DataCell(Text('₹399')),
                      DataCell(Text('UPI')),
                      DataCell(StatusChip('Enabled')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Growth')),
                      DataCell(Text('> 5')),
                      DataCell(Text('₹999')),
                      DataCell(Text('Bank transfer')),
                      DataCell(StatusChip('Pending')),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(Text('Enterprise')),
                      DataCell(Text('> 10')),
                      DataCell(Text('₹1499')),
                      DataCell(Text('UPI')),
                      DataCell(StatusChip('Review')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.name,
    required this.price,
    required this.employees,
    required this.description,
    required this.icon,
    this.highlighted = false,
  });

  final String name;
  final String price;
  final String employees;
  final String description;
  final IconData icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final color = highlighted
        ? AppColors.orange
        : Theme.of(context).colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  foregroundColor: color,
                  child: Icon(icon),
                ),
                const Spacer(),
                if (highlighted) const StatusChip('Popular'),
              ],
            ),
            const Spacer(),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              employees,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class _RenewalMethodCard extends StatelessWidget {
  const _RenewalMethodCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.chips,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.orange, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final chip in chips) StatusChip(chip)],
            ),
          ],
        ),
      ),
    );
  }
}

class TeamRolesScreen extends StatelessWidget {
  const TeamRolesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Team Roles',
      child: DataTableCard(
        title: 'Roles and access',
        columns: const [
          DataColumn(label: Text('Member')),
          DataColumn(label: Text('Role')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Status')),
        ],
        rows: [
          for (final member in teamMembers)
            DataRow(
              cells: [
                DataCell(Text(member.name)),
                DataCell(Text(member.role)),
                DataCell(Text(member.email)),
                DataCell(StatusChip(member.status)),
              ],
            ),
        ],
      ),
    );
  }
}

class AddTeamMemberScreen extends StatelessWidget {
  const AddTeamMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Add Team Member',
      child: FormSectionCard(
        title: 'Invite member',
        trailing: const StatusChip('Invitation draft'),
        children: const [
          AppTextField(label: 'Name', icon: Icons.person_rounded),
          SizedBox(height: 14),
          AppTextField(label: 'Email', icon: Icons.email_rounded),
          SizedBox(height: 14),
          AppTextField(label: 'Role', icon: Icons.admin_panel_settings_rounded),
        ],
      ),
    );
  }
}

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(associationsProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(associationsProvider);
    final width = MediaQuery.sizeOf(context).width;
    final publisher = state.firstPublisher;
    return AppScaffold(
      title: 'Association Notifications',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: 'Association command center',
            subtitle:
                'Price changes, trade rules, market advisories, and delivery charge updates from approved industry associations.',
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilledButton.icon(
                onPressed: publisher == null
                    ? null
                    : () => _showPublishDialog(context, ref, publisher),
                icon: const Icon(Icons.campaign_rounded),
                label: const Text('Publish alert'),
              ),
              OutlinedButton.icon(
                onPressed: () => ref.read(associationsProvider.notifier).load(),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Refresh'),
              ),
              const StatusChip('FCM foreground'),
              const StatusChip('Background'),
              const StatusChip('Terminated'),
            ],
          ),
          const SizedBox(height: 18),
          if (state.loading)
            const LinearProgressIndicator()
          else if (state.error != null)
            EmptyState(
              title: 'Association feed unavailable',
              message: state.error!,
              icon: Icons.cloud_off_rounded,
            )
          else ...[
            _AssociationMembershipStrip(associations: state.associations),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = width >= 1100 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.notices.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    mainAxisExtent: width < 560 ? 236 : 214,
                  ),
                  itemBuilder: (context, index) =>
                      _AssociationNoticeCard(notice: state.notices[index]),
                );
              },
            ),
            if (state.notices.isEmpty)
              const EmptyState(
                title: 'No association alerts',
                message:
                    'New rules, price-change circulars, and market notifications will appear here.',
                icon: Icons.notifications_none_rounded,
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _showPublishDialog(
    BuildContext context,
    WidgetRef ref,
    AssociationSummary association,
  ) async {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    var severity = AssociationNotificationSeverity.priceChange;
    var publishing = false;

    await showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Publish association alert'),
              content: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          prefixIcon: Icon(Icons.title_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<AssociationNotificationSeverity>(
                        initialValue: severity,
                        decoration: const InputDecoration(
                          labelText: 'Severity',
                          prefixIcon: Icon(Icons.priority_high_rounded),
                        ),
                        items: [
                          for (final item
                              in AssociationNotificationSeverity.values)
                            DropdownMenuItem(
                              value: item,
                              child: Text(item.label),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() => severity = value);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: bodyController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Notification message',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.notes_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: publishing ? null : () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: publishing
                      ? null
                      : () async {
                          setDialogState(() => publishing = true);
                          await ref
                              .read(associationsProvider.notifier)
                              .publish(
                                association: association,
                                title: titleController.text.trim(),
                                body: bodyController.text.trim(),
                                severity: severity,
                                targetStates: [
                                  if (association.state != null)
                                    association.state!,
                                ],
                              );
                          if (context.mounted) Navigator.pop(context);
                        },
                  icon: publishing
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_rounded),
                  label: const Text('Send push'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AssociationMembershipStrip extends StatelessWidget {
  const _AssociationMembershipStrip({required this.associations});

  final List<AssociationSummary> associations;

  @override
  Widget build(BuildContext context) {
    if (associations.isEmpty) {
      return const EmptyState(
        title: 'No association linked',
        message:
            'Link trade, transport, hotel, grocery, and industry associations to receive rule notifications.',
        icon: Icons.groups_2_rounded,
      );
    }
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: associations.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = associations[index];
          return SizedBox(
            width: 340,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.orange.withValues(
                            alpha: 0.12,
                          ),
                          foregroundColor: AppColors.orange,
                          child: const Icon(Icons.account_balance_rounded),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      item.industry,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        StatusChip(item.role.label),
                        if (item.state != null) StatusChip(item.state!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AssociationNoticeCard extends StatelessWidget {
  const _AssociationNoticeCard({required this.notice});

  final AssociationNotice notice;

  @override
  Widget build(BuildContext context) {
    final color = switch (notice.severity) {
      AssociationNotificationSeverity.urgent => AppColors.red,
      AssociationNotificationSeverity.priceChange => AppColors.orange,
      AssociationNotificationSeverity.advisory => AppColors.teal,
      AssociationNotificationSeverity.info => AppColors.navy,
    };
    final age = DateTime.now().difference(notice.createdAt);
    final timeLabel = age.inHours < 1
        ? '${age.inMinutes.clamp(1, 59)} min ago'
        : age.inHours < 24
        ? '${age.inHours} hr ago'
        : '${age.inDays} day ago';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.12),
                  foregroundColor: color,
                  child: const Icon(Icons.campaign_rounded),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    notice.associationName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                StatusChip(notice.severity.label),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              notice.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                notice.body,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.verified_user_rounded, size: 16, color: color),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${notice.sentByRole.label} . ${notice.sentCount} businesses',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(timeLabel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleInfoScreen extends StatelessWidget {
  const SimpleInfoScreen({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) => AppScaffold(
    title: title,
    child: EmptyState(title: title, message: message, icon: icon),
  );
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.title, required this.chips});

  final String title;
  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final chip in chips) StatusChip(chip)],
        ),
      ],
    );
  }
}

class _VoicePhrase extends StatelessWidget {
  const _VoicePhrase({
    required this.language,
    required this.phrase,
    required this.result,
  });

  final String language;
  final String phrase;
  final String result;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.orange.withValues(alpha: 0.12),
        foregroundColor: AppColors.orange,
        child: const Icon(Icons.translate_rounded),
      ),
      title: Text(
        phrase,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w800),
      ),
      subtitle: Text('$language -> $result'),
    );
  }
}

class _PrinterStatusTile extends StatelessWidget {
  const _PrinterStatusTile({
    required this.title,
    required this.subtitle,
    required this.status,
  });

  final String title;
  final String subtitle;
  final String status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.teal.withValues(alpha: 0.1),
        foregroundColor: AppColors.teal,
        child: const Icon(Icons.print_rounded),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle),
      trailing: StatusChip(status),
    );
  }
}

class _StockFlowNote extends StatelessWidget {
  const _StockFlowNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.22)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.sync_alt_rounded, color: AppColors.teal),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Workflow: supplier invoice increases store room stock, sale bill reduces shelf stock, and low-stock alerts are recalculated automatically.',
            ),
          ),
        ],
      ),
    );
  }
}

class _FlowStep extends StatelessWidget {
  const _FlowStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
            child: Text(
              number,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanDropZone extends StatelessWidget {
  const _ScanDropZone({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: 'Upload or capture bill',
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.45),
            ),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.document_scanner_rounded,
                size: 58,
                color: AppColors.orange,
              ),
              SizedBox(height: 12),
              Text(
                'Camera scan, image upload, or PDF supplier invoice',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 6),
              Text(
                'Designed for phone camera, tablet camera, desktop upload, and PWA install flow.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        PrimaryButton(
          label: 'Start scanning',
          icon: Icons.center_focus_strong_rounded,
          onPressed: onStart,
          accent: true,
        ),
      ],
    );
  }
}

class _ScanRulesCard extends StatelessWidget {
  const _ScanRulesCard();

  @override
  Widget build(BuildContext context) {
    return const FormSectionCard(
      title: 'What OCR extracts',
      children: [
        _FlowStep(
          number: '1',
          title: 'Product and brand',
          subtitle: 'Matches bill item names with existing grocery inventory.',
        ),
        _FlowStep(
          number: '2',
          title: 'Quantity and unit',
          subtitle:
              'Supports kg, gram, litre, ml, packet, piece, box, and bag.',
        ),
        _FlowStep(
          number: '3',
          title: 'Purchase and MRP',
          subtitle: 'Stores margin-friendly purchase rate and sale price.',
        ),
        _FlowStep(
          number: '4',
          title: 'Auto stock entry',
          subtitle: 'Confirmed rows increase store room inventory.',
        ),
      ],
    );
  }
}

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 380;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                (compact
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.headlineMedium)
                    ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style:
                (compact
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodyLarge)
                    ?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
          ),
        ],
      ),
    );
  }
}

class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 1200;
    final tablet = width >= 700 && width < 1200;
    final tiny = width < 360;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: children.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: desktop
            ? 16
            : tablet
            ? 14
            : tiny
            ? 5
            : 8,
        mainAxisSpacing: desktop
            ? 16
            : tablet
            ? 14
            : tiny
            ? 5
            : 8,
        mainAxisExtent: desktop
            ? 188
            : tablet
            ? 176
            : tiny
            ? 142
            : 156,
      ),
      itemBuilder: (context, index) => children[index],
    );
  }
}

class ModuleGrid extends StatelessWidget {
  const ModuleGrid({super.key, required this.modules});

  final List<Widget> modules;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1180
        ? 3
        : width >= 560
        ? 2
        : 1;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: width < 380 ? 112 : 104,
      ),
      itemBuilder: (context, index) => modules[index],
    );
  }
}

class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({
    super.key,
    required this.children,
    this.desktopColumns = 3,
    this.tabletColumns = 2,
    this.rowExtent = 140,
  });

  final List<Widget> children;
  final int desktopColumns;
  final int tabletColumns;
  final double rowExtent;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final desktop = width >= 1180;
    final tablet = width >= 640 && width < 1180;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: children.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: desktop
            ? desktopColumns
            : tablet
            ? tabletColumns
            : 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: rowExtent,
      ),
      itemBuilder: (context, index) => children[index],
    );
  }
}
