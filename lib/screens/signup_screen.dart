import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';
import '../models/models.dart';
import '../widgets/app_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() { _name.dispose(); _email.dispose(); _password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text('Create Account', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Join PlaySpace today', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.muted)),
              const SizedBox(height: 32),
              AppTextField(
                controller: _name,
                label: 'Full Name',
                hint: 'e.g. Sarah Johnson',
                textCapitalization: TextCapitalization.words,
                prefixIcon: const Icon(Icons.person_outlined),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _email,
                label: 'Email',
                hint: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _password,
                label: 'Password',
                hint: 'Min. 8 characters',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outlined),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty || _password.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill in all fields'), backgroundColor: AppColors.error),
                      );
                      return;
                    }
                    final current = ref.read(currentUserProvider);
                    ref.read(currentUserProvider.notifier).state = User(
                      name: _name.text.trim(),
                      email: _email.text.trim(),
                      phone: current.phone,
                      hasActiveWaiver: current.hasActiveWaiver,
                      membershipType: current.membershipType,
                    );
                    ref.read(isAuthenticatedProvider.notifier).state = true;
                  },
                  child: const Text('Create Account'),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.muted)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or sign up with', style: Theme.of(context).textTheme.bodySmall),
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
                  onPressed: () => context.go('/login'),
                  child: const Text.rich(TextSpan(children: [
                    TextSpan(text: 'Already have an account? ', style: TextStyle(color: AppColors.muted)),
                    TextSpan(text: 'Sign In', style: TextStyle(color: AppColors.coral, fontWeight: FontWeight.w700)),
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
