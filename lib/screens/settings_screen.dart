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
                      onPressed: () {},
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
              value: true,
              onChanged: (_) {},
            ),
            _toggleTile(
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              subtitle: 'Weekly schedule & offers',
              value: true,
              onChanged: (_) {},
            ),
            _toggleTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              subtitle: 'Coming soon',
              value: false,
              onChanged: null,
            ),

            // Support section
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
              child: Text('Support', style: Theme.of(context).textTheme.titleMedium),
            ),

            _settingsTile(
              icon: Icons.help_outline,
              title: 'Help & FAQ',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.chat_bubble_outline,
              title: 'Contact Support',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.star_outline,
              title: 'Rate PlaySpace',
              onTap: () {},
            ),
            _settingsTile(
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {},
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
