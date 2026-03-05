import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class TaskDetailHeader extends StatelessWidget {
  const TaskDetailHeader({
    super.key,
    required this.taskTitle,
    required this.timeLabel,
  });

  final String taskTitle;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionTitle(title: taskTitle),
          const SizedBox(height: AppSpacing.space8),
          BodyText(
            text: timeLabel,
            maxLines: 1,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
