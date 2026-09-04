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
  final _controller = SignatureController(penStrokeWidth: 2, penColor: AppColors.navy);
  bool _agreed = false;

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liability Waiver')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.golden.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.golden),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Please read and sign the waiver below. This is required before checking in.',
                      style: TextStyle(fontSize: 13, color: AppColors.navy),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.muted.withValues(alpha: 0.2)),
              ),
              child: const Text(
                'ASSUMPTION OF RISK AND WAIVER OF LIABILITY\n\n'
                'I hereby acknowledge and assume all risks associated with my child\'s participation in activities at PlaySpace. '
                'I understand that physical activities involve inherent risks including but not limited to: falls, collisions, '
                'and other accidents.\n\n'
                'I voluntarily waive any and all claims against PlaySpace, its owners, employees, and affiliates '
                'from any and all liability, claims, demands, or causes of action arising from my child\'s participation.\n\n'
                'I confirm that I am the legal guardian of the child(ren) listed in my family profile and have the authority '
                'to sign this waiver on their behalf.',
                style: TextStyle(fontSize: 13, height: 1.6),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Your Signature', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.muted.withValues(alpha: 0.3)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Signature(controller: _controller, backgroundColor: AppColors.surface),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _controller.clear(),
                child: const Text('Clear Signature'),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v ?? false),
                  activeColor: AppColors.coral,
                ),
                const Expanded(
                  child: Text('I have read and agree to the terms above', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _agreed
                    ? () {
                        ref.read(currentUserProvider.notifier).state = User(
                          id: ref.read(currentUserProvider).id,
                          name: ref.read(currentUserProvider).name,
                          email: ref.read(currentUserProvider).email,
                          phone: ref.read(currentUserProvider).phone,
                          hasActiveWaiver: true,
                          membershipType: ref.read(currentUserProvider).membershipType,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Waiver signed successfully!'), backgroundColor: AppColors.mint),
                        );
                      }
                    : null,
                child: const Text('Sign & Accept'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
