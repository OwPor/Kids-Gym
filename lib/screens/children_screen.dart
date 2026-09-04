import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import '../providers/providers.dart';
import '../models/models.dart';

class ChildrenScreen extends ConsumerWidget {
  const ChildrenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = ref.watch(childrenProvider);
    final colors = [AppColors.coral, AppColors.golden, AppColors.mint, Color(0xFF818CF8)];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Kids', style: Theme.of(context).textTheme.headlineSmall),
                IconButton(
                  onPressed: () => _showAddChildDialog(context, ref),
                  icon: const Icon(Icons.add_circle, color: AppColors.coral, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('${children.length} child${children.length == 1 ? '' : 'en'} registered',
                style: const TextStyle(color: AppColors.muted, fontSize: 14)),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: children.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.child_care, size: 64, color: AppColors.muted.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        const Text('No children added yet', style: TextStyle(color: AppColors.muted, fontSize: 16)),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => _showAddChildDialog(context, ref),
                          icon: const Icon(Icons.add),
                          label: const Text('Add Child'),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: children.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      final child = children[i];
                      final color = colors[i % colors.length];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: color.withValues(alpha: 0.15),
                                    child: Text(
                                      child.name[0],
                                      style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(child.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                                        const SizedBox(height: 2),
                                        Text('Age ${child.age}', style: const TextStyle(color: AppColors.muted, fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (v) {
                                      if (v == 'delete') {
                                        ref.read(childrenProvider.notifier).removeChild(child.id);
                                      }
                                    },
                                    itemBuilder: (_) => [
                                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                      const PopupMenuItem(value: 'delete', child: Text('Delete', style: TextStyle(color: AppColors.error))),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoRow(Icons.cake, 'Born', '${child.dateOfBirth.month}/${child.dateOfBirth.day}/${child.dateOfBirth.year}'),
                                    const SizedBox(height: 8),
                                    _infoRow(
                                      Icons.warning_amber,
                                      'Allergies',
                                      child.allergies.isEmpty ? 'None listed' : child.allergies,
                                      valueColor: child.allergies.isEmpty ? AppColors.muted : AppColors.error,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit_calendar, size: 16),
                                      label: const Text('Book'),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.history, size: 16),
                                      label: const Text('History'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.muted),
        const SizedBox(width: 8),
        Text('$label: ', style: const TextStyle(color: AppColors.muted, fontSize: 13)),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: valueColor ?? AppColors.navy, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  void _showAddChildDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final allergyCtrl = TextEditingController();
    DateTime dob = DateTime.now().subtract(const Duration(days: 365 * 4));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: StatefulBuilder(
          builder: (ctx, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Child', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(hintText: 'Child\'s name'),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: ctx,
                    initialDate: dob,
                    firstDate: DateTime(2018),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) setState(() => dob = picked);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.muted.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    'DOB: ${dob.month}/${dob.day}/${dob.year}',
                    style: const TextStyle(color: AppColors.navy),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: allergyCtrl,
                decoration: const InputDecoration(hintText: 'Allergies (optional)'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isNotEmpty) {
                      ref.read(childrenProvider.notifier).addChild(
                        Child(name: nameCtrl.text.trim(), dateOfBirth: dob, allergies: allergyCtrl.text.trim()),
                      );
                      Navigator.pop(ctx);
                    }
                  },
                  child: const Text('Add Child'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
