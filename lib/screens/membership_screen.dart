import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';

class MembershipScreen extends ConsumerWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plans = ref.watch(membershipPlansProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Membership Plans')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose Your Plan', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Flexible options for every family', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.muted)),
            const SizedBox(height: 24),
            ...plans.map((plan) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${plan.name} selected! (Demo)'), backgroundColor: AppColors.mint),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: plan.isPopular ? AppColors.coral : AppColors.muted.withValues(alpha: 0.2),
                      width: plan.isPopular ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(plan.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                          ),
                          if (plan.isPopular)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.coral, borderRadius: BorderRadius.circular(20)),
                              child: const Text('Popular', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(plan.price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.coral)),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(plan.period, style: const TextStyle(color: AppColors.muted)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(plan.description, style: const TextStyle(color: AppColors.muted)),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: plan.isPopular
                            ? ElevatedButton(onPressed: () {}, child: const Text('Subscribe'))
                            : OutlinedButton(onPressed: () {}, child: const Text('Select Plan')),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
