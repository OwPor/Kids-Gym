import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),

            // Profile Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.coral.withValues(alpha: 0.15),
                      child: const Icon(Icons.person, color: AppColors.coral, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          Text(user.email, style: const TextStyle(fontSize: 13, color: AppColors.muted)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.muted),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Menu Items
            _MenuItem(icon: Icons.receipt_long, title: 'Membership', subtitle: user.membershipType, onTap: () => context.push('/membership')),
            _MenuItem(icon: Icons.description, title: 'Waiver', subtitle: user.hasActiveWaiver ? 'Active' : 'Required', onTap: () => context.push('/waiver')),
            _MenuItem(icon: Icons.notifications_outlined, title: 'Notifications', onTap: () {}),
            _MenuItem(icon: Icons.help_outline, title: 'Help & Support', onTap: () {}),
            _MenuItem(icon: Icons.info_outline, title: 'About', onTap: () {}),
            const SizedBox(height: 24),

            // Sign Out
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(isAuthenticatedProvider.notifier).state = false;
                  context.go('/login');
                },
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.error)),
                child: const Text('Sign Out', style: TextStyle(color: AppColors.error)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.title, this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: AppColors.coral),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.muted)) : null,
        trailing: const Icon(Icons.chevron_right, color: AppColors.muted),
        onTap: onTap,
      ),
    );
  }
}
