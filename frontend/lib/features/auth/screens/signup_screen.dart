import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/brand_logo.dart';
import '../../../core/widgets/common_widgets.dart';
import '../providers/auth_provider.dart';

class AuthSignupScreen extends ConsumerStatefulWidget {
  const AuthSignupScreen({super.key});

  @override
  ConsumerState<AuthSignupScreen> createState() => _AuthSignupScreenState();
}

class _AuthSignupScreenState extends ConsumerState<AuthSignupScreen> {
  final _fullName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController(text: 'Password@123');

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BrandLogo(),
                      const SizedBox(height: 24),
                      Text(
                        'Owner signup',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _fullName,
                        decoration: const InputDecoration(
                          labelText: 'Full name',
                          prefixIcon: Icon(Icons.person_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_rounded),
                        ),
                      ),
                      const SizedBox(height: 18),
                      PrimaryButton(
                        label: 'Continue to company registration',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () {
                          ref
                              .read(authProvider.notifier)
                              .saveSignupDraft(
                                SignupDraft(
                                  fullName: _fullName.text.trim(),
                                  email: _email.text.trim(),
                                  phone: _phone.text.trim(),
                                  password: _password.text,
                                ),
                              );
                          context.go('/company-registration');
                        },
                        accent: true,
                      ),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Already have an account? Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
