import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      decoration: isCompleted ? TextDecoration.lineThrough : null,
    );
    final timeStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      decoration: isCompleted ? TextDecoration.lineThrough : null,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSpacing.radiusLarge),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.space16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.all(
                Radius.circular(AppSpacing.radiusLarge),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppSpacing.minTouchTarget,
                  height: AppSpacing.minTouchTarget,
                  child: Checkbox(
                    value: isCompleted,
                    onChanged: (_) => onToggle(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Opacity(
                    opacity: isCompleted ? 0.75 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeLabel,
                          style: timeStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
