import 'package:flutter/material.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';

class TaskActionPanel extends StatelessWidget {
  const TaskActionPanel({
    super.key,
    required this.onStartFocus,
    required this.onComplete,
  });

  final VoidCallback onStartFocus;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Start Focus Session',
            onPressed: onStartFocus,
          ),
          const SizedBox(height: AppSpacing.space16),
          PrimaryButton(
            label: 'Mark as Completed',
            onPressed: onComplete,
          ),
        ],
      ),
    );
  }
}
