import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class SessionSummaryCard extends StatelessWidget {
  const SessionSummaryCard({
    super.key,
    required this.focusDuration,
    required this.motivationMessage,
  });

  final String focusDuration;
  final String motivationMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: 'Session Complete'),
          const SizedBox(height: AppSpacing.space16),
          BodyText(
            text: focusDuration,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.space8),
          BodyText(
            text: motivationMessage,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
