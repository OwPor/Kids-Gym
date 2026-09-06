import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';
import '../models/models.dart';
import '../widgets/app_text_field.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final pushNotifs = ref.watch(pushNotificationsProvider);
    final emailNotifs = ref.watch(emailNotificationsProvider);
    final darkMode = ref.watch(darkModeProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),

            // Profile card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.coral.withValues(alpha: 0.1),
                      child: const Icon(Icons.person, size: 40, color: AppColors.coral),
                    ),
                    const SizedBox(height: 12),
                    Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(user.email, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => _showEditProfileDialog(context, ref, user),
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Waiver status
            _settingsTile(
              icon: Icons.description,
              title: 'Liability Waiver',
              subtitle: user.hasActiveWaiver ? 'Active' : 'Required',
              trailingColor: user.hasActiveWaiver ? AppColors.mint : AppColors.error,
              onTap: () => context.push('/waiver'),
            ),

            // Membership
            _settingsTile(
              icon: Icons.card_membership,
              title: 'Membership',
              subtitle: user.membershipType,
              onTap: () => context.push('/membership'),
            ),

            // Preferences section
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
              child: Text('Preferences', style: Theme.of(context).textTheme.titleMedium),
            ),

            _toggleTile(
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              subtitle: 'Booking reminders & updates',
              value: pushNotifs,
              onChanged: (v) => ref.read(pushNotificationsProvider.notifier).state = v,
            ),
            _toggleTile(
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              subtitle: 'Weekly schedule & offers',
              value: emailNotifs,
              onChanged: (v) => ref.read(emailNotificationsProvider.notifier).state = v,
            ),
            _toggleTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              subtitle: darkMode ? 'On' : 'Off',
              value: darkMode,
              onChanged: (v) => ref.read(darkModeProvider.notifier).state = v,
            ),

            // Support section
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
              child: Text('Support', style: Theme.of(context).textTheme.titleMedium),
            ),

            _settingsTile(
              icon: Icons.help_outline,
              title: 'Help & FAQ',
              onTap: () => _showInfoDialog(context, 'Help & FAQ', 'Find answers to common questions about booking classes, checking in, managing your membership, and more.\n\nThis is a demo — full FAQ coming soon.'),
            ),
            _settingsTile(
              icon: Icons.chat_bubble_outline,
              title: 'Contact Support',
              onTap: () => _showInfoDialog(context, 'Contact Support', 'Email: support@playspace.com\nPhone: (555) 987-6543\nHours: Mon–Fri 9AM–5PM\n\nThis is a demo — messaging not yet implemented.'),
            ),
            _settingsTile(
              icon: Icons.star_outline,
              title: 'Rate PlaySpace',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thanks for your support! (Demo)'), backgroundColor: AppColors.golden),
                );
              },
            ),
            _settingsTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () => _showInfoDialog(context, 'About PlaySpace', 'Version 1.0.0\nBuild 2026.09.04\n\nPlaySpace makes it easy to book classes, check in, and manage your family\'s play experience.\n\nBuilt with Flutter + Riverpod.'),
            ),

            const SizedBox(height: 24),

            // Sign out
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.read(isAuthenticatedProvider.notifier).state = false;
                  context.go('/login');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Version
            const Center(
              child: Text('PlaySpace v1.0.0', style: TextStyle(color: AppColors.muted, fontSize: 12)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref, User user) {
    final nameCtrl = TextEditingController(text: user.name);
    final emailCtrl = TextEditingController(text: user.email);
    final phoneCtrl = TextEditingController(text: user.phone ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(controller: nameCtrl, label: 'Name', hint: 'e.g. Sarah Johnson'),
            const SizedBox(height: 12),
            AppTextField(controller: emailCtrl, label: 'Email', hint: 'you@example.com', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 12),
            AppTextField(controller: phoneCtrl, label: 'Phone', hint: '(555) 123-4567', keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              ref.read(currentUserProvider.notifier).state = User(
                name: nameCtrl.text.trim(),
                email: emailCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                hasActiveWaiver: user.hasActiveWaiver,
                membershipType: user.membershipType,
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated!'), backgroundColor: AppColors.mint),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? trailingColor,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: AppColors.navy),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13)) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingColor != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: trailingColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  subtitle!,
                  style: TextStyle(color: trailingColor, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.muted),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _toggleTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: SwitchListTile(
        secondary: Icon(icon, color: AppColors.navy),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.coral,
      ),
    );
  }
}
