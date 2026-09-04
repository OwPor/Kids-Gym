import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 80, height: 80,
                  decoration: const BoxDecoration(color: AppColors.coralLight, shape: BoxShape.circle),
                  child: const Icon(Icons.sports_gymnastics, size: 40, color: AppColors.coral),
                ),
              ),
              const SizedBox(height: 32),
              Text('Welcome Back', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Sign in to continue', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.muted)),
              const SizedBox(height: 32),
              TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(hintText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
              const SizedBox(height: 16),
              TextField(controller: _password, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outlined))),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {}, child: const Text('Forgot Password?')),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(isAuthenticatedProvider.notifier).state = true;
                    context.go('/home');
                  },
                  child: const Text('Sign In'),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.muted)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or continue with', style: Theme.of(context).textTheme.bodySmall),
                  ),
                  const Expanded(child: Divider(color: AppColors.muted)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref.read(isAuthenticatedProvider.notifier).state = true;
                        context.go('/home');
                      },
                      icon: const FaIcon(FontAwesomeIcons.google, size: 18),
                      label: const Text('Google'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ref.read(isAuthenticatedProvider.notifier).state = true;
                        context.go('/home');
                      },
                      icon: const FaIcon(FontAwesomeIcons.apple, size: 18),
                      label: const Text('Apple'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text.rich(TextSpan(children: [
                    TextSpan(text: "Don't have an account? ", style: TextStyle(color: AppColors.muted)),
                    TextSpan(text: 'Sign Up', style: TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700)),
                  ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
