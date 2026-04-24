import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../models/task_model.dart';
import '../../../models/time_range.dart';
import '../providers/task_provider.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskId,
  });

  final String taskId;

  Task? _findTask(List<Task> tasks) {
    for (final task in tasks) {
      if (task.id == taskId) {
        return task;
      }
    }
    return null;
  }

  String _formatTimeLabel(BuildContext context, TimeRange? timeRange) {
    if (timeRange == null || timeRange.start == null || timeRange.end == null) {
      return 'No schedule';
    }

    final start = TimeOfDay.fromDateTime(timeRange.start!).format(context);
    final end = TimeOfDay.fromDateTime(timeRange.end!).format(context);
    return '$start - $end';
  }

  void _editTask(BuildContext context, Task task) {
    context.go('/task-create', extra: task);
  }

  Widget _buildInfoBox(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.space16),
      padding: const EdgeInsets.all(AppSpacing.space16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            value,
            style: theme.textTheme.titleMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = _findTask(context.watch<TaskProvider>().tasks);
    if (task == null) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text('Task not found'),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInfoBox(
                        context,
                        label: 'Task Title',
                        value: task.title,
                      ),
                      _buildInfoBox(
                        context,
                        label: 'Time Range',
                        value: _formatTimeLabel(context, task.timeRange),
                      ),
                      _buildInfoBox(
                        context,
                        label: 'Notes',
                        value: task.notes ?? 'No notes',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space24),
              SizedBox(
                height: 48,
                child: PrimaryButton(
                  label: 'Edit Task',
                  onPressed: () => _editTask(context, task),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () => context.go('/home'),
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSpacing.radiusDefault),
                      ),
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      48,
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
