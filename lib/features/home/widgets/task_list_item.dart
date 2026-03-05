import 'package:flutter/material.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/atoms/app_icon_button.dart';
import '../../../core/atoms/app_divider.dart';
import '../../../core/theme/app_spacing.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.title,
    required this.timeLabel,
    required this.isCompleted,
    required this.onToggle,
    this.onTap,
  });

  final String title;
  final String timeLabel;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BodyText(text: title, maxLines: 1),
                      const SizedBox(height: 4),
                      BodyText(
                        text: timeLabel,
                        maxLines: 1,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                AppIconButton(
                  icon: isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  onTap: onToggle,
                  semanticLabel:
                      isCompleted ? 'Mark as incomplete' : 'Mark as complete',
                ),
              ],
            ),
          ),
        ),
        const AppDivider(verticalSpacing: 0),
      ],
    );
  }
}
