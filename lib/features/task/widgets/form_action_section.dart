import 'package:flutter/material.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';

class FormActionSection extends StatelessWidget {
  const FormActionSection({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Save Task',
            onPressed: onSave,
          ),
          const SizedBox(height: AppSpacing.space16),
          PrimaryButton(
            label: 'Cancel',
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}
