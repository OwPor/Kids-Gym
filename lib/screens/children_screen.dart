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

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kids Profiles', style: Theme.of(context).textTheme.headlineSmall),
                IconButton(
                  onPressed: () => _showAddChildDialog(context, ref),
                  icon: const Icon(Icons.add_circle, color: AppColors.coral),
                ),
              ],
            ),
          ),
          Expanded(
            child: children.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.child_care, size: 64, color: AppColors.muted.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        const Text('No kids added yet', style: TextStyle(color: AppColors.muted)),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () => _showAddChildDialog(context, ref),
                          icon: const Icon(Icons.add),
                          label: const Text('Add Child'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: children.length,
                    itemBuilder: (_, i) {
                      final child = children[i];
                      final colors = [AppColors.coral, AppColors.golden, AppColors.mint];
                      final color = colors[i % 3];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: color.withValues(alpha: 0.15),
                                child: Text(child.name[0], style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(child.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 4),
                                    Text('Age ${child.age} • Born ${child.dateOfBirth.month}/${child.dateOfBirth.day}/${child.dateOfBirth.year}',
                                        style: const TextStyle(fontSize: 13, color: AppColors.muted)),
                                    if (child.allergies.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.warning_amber, size: 12, color: AppColors.golden),
                                          const SizedBox(width: 4),
                                          Text('Allergies: ${child.allergies}', style: const TextStyle(fontSize: 12, color: AppColors.golden)),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => ref.read(childrenProvider.notifier).removeChild(child.id),
                                icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
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

  void _showAddChildDialog(BuildContext context, WidgetRef ref) {
    final name = TextEditingController();
    final allergies = TextEditingController();
    DateTime dob = DateTime.now().subtract(const Duration(days: 365 * 3));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Add Child', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 16),
              TextField(controller: name, textCapitalization: TextCapitalization.words, decoration: const InputDecoration(hintText: 'Child\'s Name')),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Date of Birth'),
                subtitle: Text('${dob.month}/${dob.day}/${dob.year}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(context: ctx, initialDate: dob, firstDate: DateTime(2015), lastDate: DateTime.now());
                  if (picked != null) setModalState(() => dob = picked);
                },
              ),
              TextField(controller: allergies, decoration: const InputDecoration(hintText: 'Allergies (optional)')),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (name.text.isNotEmpty) {
                      ref.read(childrenProvider.notifier).addChild(Child(name: name.text, dateOfBirth: dob, allergies: allergies.text));
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
