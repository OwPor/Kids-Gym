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

            // Profile header — horizontal layout
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.coral.withValues(alpha: 0.1),
                      child: const Icon(Icons.person, size: 32, color: AppColors.coral),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(user.email, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _profileChip(user.membershipType, AppColors.coral),
                              _profileChip(
                                user.hasActiveWaiver ? 'Waiver Active' : 'Waiver Required',
                                user.hasActiveWaiver ? AppColors.mint : AppColors.error,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _showEditProfileDialog(context, ref, user),
                      icon: const Icon(Icons.edit_outlined),
                      color: AppColors.coral,
                      tooltip: 'Edit profile',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Waiver status
            _settingsTile(context, 
              icon: Icons.description,
              title: 'Liability Waiver',
              subtitle: user.hasActiveWaiver ? 'Active' : 'Required',
              trailingColor: user.hasActiveWaiver ? AppColors.mint : AppColors.error,
              onTap: () => context.push('/waiver'),
            ),

            // Membership
            _settingsTile(context, 
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

            _toggleTile(context, 
              icon: Icons.notifications_outlined,
              title: 'Push Notifications',
              subtitle: 'Booking reminders & updates',
              value: pushNotifs,
              onChanged: (v) => ref.read(pushNotificationsProvider.notifier).state = v,
            ),
            _toggleTile(context, 
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              subtitle: 'Weekly schedule & offers',
              value: emailNotifs,
              onChanged: (v) => ref.read(emailNotificationsProvider.notifier).state = v,
            ),
            _toggleTile(context, 
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

            _settingsTile(context, 
              icon: Icons.help_outline,
              title: 'Help & FAQ',
              onTap: () => _showInfoDialog(context, 'Help & FAQ', 'Find answers to common questions about booking classes, checking in, managing your membership, and more.\n\nThis is a demo — full FAQ coming soon.'),
            ),
            _settingsTile(context, 
              icon: Icons.chat_bubble_outline,
              title: 'Contact Support',
              onTap: () => _showInfoDialog(context, 'Contact Support', 'Email: support@playspace.com\nPhone: (555) 987-6543\nHours: Mon–Fri 9AM–5PM\n\nThis is a demo — messaging not yet implemented.'),
            ),
            _settingsTile(context, 
              icon: Icons.star_outline,
              title: 'Rate PlaySpace',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thanks for your support! (Demo)'), backgroundColor: AppColors.golden),
                );
              },
            ),
            _settingsTile(context, 
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            AppTextField(controller: nameCtrl, label: 'Name', hint: 'e.g. Sarah Johnson'),
            const SizedBox(height: 16),
            AppTextField(controller: emailCtrl, label: 'Email', hint: 'you@example.com', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            AppTextField(controller: phoneCtrl, label: 'Phone', hint: '(555) 123-4567', keyboardType: TextInputType.phone),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _settingsTile(BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Color? trailingColor,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
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

  Widget _toggleTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: SwitchListTile(
        secondary: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.coral,
      ),
    );
  }
}
