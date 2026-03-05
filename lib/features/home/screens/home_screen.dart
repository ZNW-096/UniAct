import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/today_progress_section.dart';
import '../widgets/task_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.completed,
    required this.total,
    required this.tasks,
    required this.onToggle,
    this.onTaskTap,
    this.onAddTask,
    this.onStartFocus,
  });

  final int completed;
  final int total;
  final List<Map<String, dynamic>> tasks;
  final Function(int) onToggle;
  final Function(int)? onTaskTap;
  final VoidCallback? onAddTask;
  final VoidCallback? onStartFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onStartFocus != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.space8),
              child: FloatingActionButton.extended(
                heroTag: 'start_focus',
                onPressed: onStartFocus,
                label: const Text('Start Focus'),
                icon: const Icon(Icons.timer),
              ),
            ),
          if (onAddTask != null)
            FloatingActionButton(
              heroTag: 'add_task',
              onPressed: onAddTask,
              child: const Icon(Icons.add),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TodayProgressSection(
              completed: completed,
              total: total,
            ),
            const SizedBox(height: AppSpacing.space8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskListItem(
                    title: task['title'] as String,
                    timeLabel: task['timeLabel'] as String,
                    isCompleted: task['isCompleted'] as bool,
                    onToggle: () => onToggle(index),
                    onTap: onTaskTap != null ? () => onTaskTap!(index) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
