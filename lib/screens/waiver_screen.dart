import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';
import '../models/models.dart';

class WaiverScreen extends ConsumerStatefulWidget {
  const WaiverScreen({super.key});

  @override
  ConsumerState<WaiverScreen> createState() => _WaiverScreenState();
}

class _WaiverScreenState extends ConsumerState<WaiverScreen> {
  final SignatureController _sigController = SignatureController(
    penStrokeWidth: 3,
    penColor: AppColors.navy,
    exportBackgroundColor: AppColors.surface,
  );
  bool _agreed = false;
  bool _signed = false;

  @override
  void dispose() {
    _sigController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liability Waiver'),
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
            // Waiver text
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.muted.withValues(alpha: 0.2)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PlaySpace Liability Waiver & Release',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'By signing below, I acknowledge and agree that my child\'s participation in activities at PlaySpace involves inherent risks including but not limited to falls, collisions, and minor injuries.\n\n'
                    'I hereby release, waive, and discharge PlaySpace, its owners, employees, and affiliates from any and all liability, claims, demands, or causes of action arising from my child\'s participation.\n\n'
                    'I confirm that my child is physically capable of participating and I have disclosed any relevant medical conditions.\n\n'
                    'This waiver is valid for 12 months from the date signed.',
                    style: TextStyle(fontSize: 14, color: AppColors.navy, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Signature
            Text('Your Signature', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _signed ? AppColors.mint : AppColors.muted.withValues(alpha: 0.3),
                  width: _signed ? 2 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Signature(
                  controller: _sigController,
                  backgroundColor: AppColors.surface,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    _sigController.clear();
                    setState(() => _signed = false);
                  },
                  child: const Text('Clear'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    if (_sigController.isNotEmpty) {
                      setState(() => _signed = true);
                    }
                  },
                  child: const Text('Confirm Signature'),
                ),
              ],
            ),
            if (_signed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 16, color: AppColors.mint),
                    SizedBox(width: 6),
                    Text('Signature captured', style: TextStyle(color: AppColors.mint, fontWeight: FontWeight.w600, fontSize: 13)),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            // Agreement checkbox
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                  activeColor: AppColors.coral,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                const Expanded(
                  child: Text(
                    'I have read and agree to the waiver terms',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Submit
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_agreed && _signed) ? () {
                  final current = ref.read(currentUserProvider);
                  ref.read(currentUserProvider.notifier).state = User(
                    name: current.name,
                    email: current.email,
                    phone: current.phone,
                    hasActiveWaiver: true,
                    membershipType: current.membershipType,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Waiver signed successfully!'), backgroundColor: AppColors.mint),
                  );
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/home');
                  }
                } : null,
                child: const Text('Submit Waiver'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
