import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';
import '../models/models.dart';

class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(membershipPlansProvider);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Membership'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current plan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.coral, Color(0xFFFF8A65)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: AppColors.coral.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Plan', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(
                    user.membershipType,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _statBadge('Visits Used', '12'),
                      const SizedBox(width: 12),
                      _statBadge('Visits Left', 'Unlimited'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Upgrade or Change Plan', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),

            ...plans.map((plan) {
              final isCurrent = user.membershipType == plan.name;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: isCurrent ? const BorderSide(color: AppColors.mint, width: 2) : BorderSide.none,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(plan.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                      if (plan.isPopular) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: AppColors.golden,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text('Popular', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                                        ),
                                      ],
                                      if (isCurrent) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: AppColors.mint,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Text('Current', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(plan.description, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: plan.price,
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.onSurface),
                                children: [TextSpan(text: ' ${plan.period}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.muted))],
                              ),
                            ),
                            isCurrent
                                ? const OutlinedButton(
                                    onPressed: null,
                                    child: Text('Current Plan'),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      ref.read(currentUserProvider.notifier).state = User(
                                        name: user.name,
                                        email: user.email,
                                        phone: user.phone,
                                        hasActiveWaiver: user.hasActiveWaiver,
                                        membershipType: plan.name,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Switched to ${plan.name}!'),
                                          backgroundColor: AppColors.mint,
                                        ),
                                      );
                                    },
                                    child: const Text('Select Plan'),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),
            // Perks section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Membership Perks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _perkItem(Icons.event_available, 'Priority booking for classes'),
                    _perkItem(Icons.fitness_center, 'Unlimited open play access'),
                    _perkItem(Icons.celebration, 'Free birthday party hosting'),
                    _perkItem(Icons.local_offer, '10% off retail & snacks'),
                    _perkItem(Icons.family_restroom, 'Family member discounts'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBadge(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }

  Widget _perkItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.mint),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
