import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/company_onboarding_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyRegistrationScreen extends ConsumerStatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  ConsumerState<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState
    extends ConsumerState<CompanyRegistrationScreen> {
  final legalName = TextEditingController(text: 'ABC Stores');
  final tradeName = TextEditingController(text: 'ABC Grocery');
  final industry = TextEditingController(text: 'Retail Grocery');
  final stateName = TextEditingController(text: 'Tamil Nadu');
  final city = TextEditingController(text: 'Tiruchengode');
  final address = TextEditingController(text: 'Address');
  final pincode = TextEditingController(text: '637209');
  final employeeCount = TextEditingController(text: '3');
  final monthlyRevenue = TextEditingController(text: '300000');
  final branchCount = TextEditingController(text: '1');
  final skuCount = TextEditingController(text: '800');
  final invoiceVolume = TextEditingController(text: '300');

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final selectedType = ref.watch(selectedBusinessTypeProvider);
    const types = [
      'GROCERY',
      'RETAIL',
      'WHOLESALE',
      'MANUFACTURING',
      'SERVICES',
      'PHARMACY',
      'TEXTILE',
      'RESTAURANT',
      'DISTRIBUTION',
      'OTHER',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Company Registration')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: FormSectionCard(
                title: 'Business profile for auto classification',
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: legalName,
                          decoration: const InputDecoration(
                            labelText: 'Legal name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: tradeName,
                          decoration: const InputDecoration(
                            labelText: 'Trade name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField<String>(
                          initialValue: selectedType,
                          items: [
                            for (final type in types)
                              DropdownMenuItem(value: type, child: Text(type)),
                          ],
                          onChanged: (value) =>
                              ref
                                      .read(
                                        selectedBusinessTypeProvider.notifier,
                                      )
                                      .state =
                                  value ?? 'GROCERY',
                          decoration: const InputDecoration(
                            labelText: 'Business type',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: industry,
                          decoration: const InputDecoration(
                            labelText: 'Industry',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: stateName,
                          decoration: const InputDecoration(labelText: 'State'),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: city,
                          decoration: const InputDecoration(labelText: 'City'),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: address,
                          decoration: const InputDecoration(
                            labelText: 'Address',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextField(
                          controller: pincode,
                          decoration: const InputDecoration(
                            labelText: 'Pincode',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextField(
                          controller: employeeCount,
                          decoration: const InputDecoration(
                            labelText: 'Employees',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: monthlyRevenue,
                          decoration: const InputDecoration(
                            labelText: 'Monthly revenue',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextField(
                          controller: branchCount,
                          decoration: const InputDecoration(
                            labelText: 'Branches',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: TextField(
                          controller: skuCount,
                          decoration: const InputDecoration(
                            labelText: 'SKU count',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: TextField(
                          controller: invoiceVolume,
                          decoration: const InputDecoration(
                            labelText: 'Invoice volume',
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (auth.error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      auth.error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryButton(
                      label: auth.loading
                          ? 'Creating account...'
                          : 'Create account & classify',
                      icon: Icons.auto_awesome_rounded,
                      onPressed: auth.loading
                          ? () {}
                          : () async {
                              await ref
                                  .read(authProvider.notifier)
                                  .signupWithCompany({
                                    'legalName': legalName.text.trim(),
                                    'tradeName': tradeName.text.trim(),
                                    'businessType': selectedType,
                                    'industry': industry.text.trim(),
                                    'state': stateName.text.trim(),
                                    'city': city.text.trim(),
                                    'address': address.text.trim(),
                                    'pincode': pincode.text.trim(),
                                    'employeeCount':
                                        int.tryParse(employeeCount.text) ?? 1,
                                    'monthlyRevenue':
                                        num.tryParse(monthlyRevenue.text) ?? 0,
                                    'branchCount':
                                        int.tryParse(branchCount.text) ?? 1,
                                    'skuCount':
                                        int.tryParse(skuCount.text) ?? 0,
                                    'invoiceVolume':
                                        int.tryParse(invoiceVolume.text) ?? 0,
                                    'hasGST': false,
                                  });
                              if (context.mounted &&
                                  ref.read(authProvider).isAuthenticated) {
                                context.go('/classification-result');
                              }
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
