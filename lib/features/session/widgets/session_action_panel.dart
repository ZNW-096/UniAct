import 'package:flutter/material.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';

class SessionActionPanel extends StatelessWidget {
  const SessionActionPanel({
    super.key,
    required this.onRestart,
    required this.onBackHome,
  });

  final VoidCallback onRestart;
  final VoidCallback onBackHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Start Another Session',
            onPressed: onRestart,
          ),
          const SizedBox(height: AppSpacing.space16),
          PrimaryButton(
            label: 'Back to Today',
            onPressed: onBackHome,
          ),
        ],
      ),
    );
  }
}
