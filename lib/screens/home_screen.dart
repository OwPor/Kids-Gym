import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final children = ref.watch(childrenProvider);
    final bookings = ref.watch(bookingsProvider);
    final upcoming = bookings.where((b) => b.isBooked).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.coral.withValues(alpha: 0.1),
                  child: const Icon(Icons.person, color: AppColors.coral),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi, ${user.name.split(' ').first}!', style: Theme.of(context).textTheme.titleLarge),
                      Text(user.membershipType, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: user.membershipType != 'None' ? AppColors.mint.withValues(alpha: 0.1) : AppColors.muted.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        user.membershipType != 'None' ? Icons.check_circle : Icons.info_outline,
                        size: 16,
                        color: user.membershipType != 'None' ? AppColors.mint : AppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        user.membershipType != 'None' ? 'Active' : 'No Plan',
                        style: TextStyle(
                          color: user.membershipType != 'None' ? AppColors.mint : AppColors.muted,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Check-In Button
            GestureDetector(
              onTap: () => context.go('/checkin'),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [AppColors.coral, Color(0xFFFF8A65)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppColors.coral.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: const Column(
                  children: [
                    Icon(Icons.qr_code_scanner, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text('Tap to Check In', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                    SizedBox(height: 4),
                    Text('Show QR code at front desk', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Children
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Kids', style: Theme.of(context).textTheme.titleMedium),
                TextButton(
                  onPressed: () => context.go('/children'),
                  child: const Text('See All'),
                ),
              ],
            ),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: children.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (_, i) {
                  final child = children[i];
                  return Container(
                    width: 160,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.muted.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: [AppColors.coral, AppColors.golden, AppColors.mint][i % 3].withValues(alpha: 0.15),
                          child: Text(child.name[0], style: TextStyle(color: [AppColors.coral, AppColors.golden, AppColors.mint][i % 3], fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(child.name.split(' ').first, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), overflow: TextOverflow.ellipsis),
                              Text('Age ${child.age}', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Upcoming Bookings
            Text('Upcoming Bookings', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            if (upcoming.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.event_busy, size: 40, color: AppColors.muted.withValues(alpha: 0.5)),
                        const SizedBox(height: 8),
                        const Text('No upcoming bookings', style: TextStyle(color: AppColors.muted)),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => context.go('/booking'),
                          child: const Text('Browse Classes'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...upcoming.take(3).map((b) => Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.mint.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.fitness_center, color: AppColors.mint),
                      ),
                      title: Text(b.className, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(b.timeSlot, style: const TextStyle(fontSize: 13)),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppColors.mint.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                        child: const Text('Booked', style: TextStyle(color: AppColors.mint, fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
