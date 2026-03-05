import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';

class FocusSessionControlPanel extends StatelessWidget {
  const FocusSessionControlPanel({
    super.key,
    required this.timerLabel,
    required this.onStartLong,
    required this.onStartShort,
  });

  final String timerLabel;
  final VoidCallback onStartLong;
  final VoidCallback onStartShort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: 'Focus Session'),
          const SizedBox(height: AppSpacing.space24),
          BodyText(
            text: timerLabel,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          const SizedBox(height: AppSpacing.space24),
          PrimaryButton(
            label: 'Start 25-Min Focus',
            onPressed: onStartLong,
          ),
          const SizedBox(height: AppSpacing.space16),
          PrimaryButton(
            label: 'Start 2-Min Quick Focus',
            onPressed: onStartShort,
          ),
        ],
      ),
    );
  }
}
