import 'package:flutter/material.dart';
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/brand_logo.dart';
import '../../../core/widgets/common_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLoginScreen extends ConsumerStatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  ConsumerState<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends ConsumerState<AuthLoginScreen> {
  final _email = TextEditingController(text: 'grocery@demo.com');
  final _password = TextEditingController(text: 'Password@123');

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BrandLogo(),
                      const SizedBox(height: 24),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Load your company profile and personalized dashboard.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_rounded),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_rounded),
                        ),
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
                      PrimaryButton(
                        label: auth.loading ? 'Logging in...' : 'Login',
                        icon: Icons.login_rounded,
                        onPressed: auth.loading
                            ? () {}
                            : () async {
                                await ref
                                    .read(authProvider.notifier)
                                    .login(_email.text.trim(), _password.text);
                                if (context.mounted &&
                                    ref.read(authProvider).isAuthenticated) {
                                  context.go('/dashboard');
                                }
                              },
                        accent: true,
                      ),
                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text('Create a new company account'),
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
