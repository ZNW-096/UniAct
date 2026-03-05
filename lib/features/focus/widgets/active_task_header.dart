import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class ActiveTaskHeader extends StatelessWidget {
  const ActiveTaskHeader({
    super.key,
    required this.taskTitle,
  });

  final String taskTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionTitle(title: taskTitle),
          const SizedBox(height: AppSpacing.space8),
          const BodyText(
            text: 'Deep Focus Mode',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
