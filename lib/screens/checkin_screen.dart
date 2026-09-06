import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';

class CheckInScreen extends ConsumerWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Check In', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Show this QR code at the front desk',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Column(
                children: [
                  QrImageView(
                    data: 'playspace://checkin?user=${user.id}&name=${Uri.encodeComponent(user.name)}',
                    version: QrVersions.auto,
                    size: 220,
                  ),
                  const SizedBox(height: 16),
                  Text(user.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.mint.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, size: 14, color: AppColors.mint),
                        const SizedBox(width: 4),
                        Text(user.membershipType, style: const TextStyle(color: AppColors.mint, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      user.hasActiveWaiver ? Icons.verified : Icons.warning_amber,
                      color: user.hasActiveWaiver ? AppColors.mint : AppColors.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.hasActiveWaiver ? 'Waiver Active' : 'Waiver Required',
                            style: TextStyle(fontWeight: FontWeight.w600, color: user.hasActiveWaiver ? AppColors.mint : AppColors.error),
                          ),
                          Text(
                            user.hasActiveWaiver ? 'Your liability waiver is on file' : 'Sign a waiver before checking in',
                            style: const TextStyle(fontSize: 13, color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    if (!user.hasActiveWaiver)
                      TextButton(
                        onPressed: () => context.push('/waiver'),
                        child: const Text('Sign Now'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
