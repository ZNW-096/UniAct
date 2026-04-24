import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '../../../models/time_range.dart';
import '../../../core/theme/app_spacing.dart';
import '../../task/providers/task_provider.dart';
import '../widgets/today_progress_section.dart';
import '../widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().listenToTasks();
    });
  }

  Future<void> _toggleTask(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      notes: task.notes,
      timeRange: task.timeRange,
      isCompleted: !task.isCompleted,
    );
    await context.read<TaskProvider>().updateTask(updatedTask);
  }

  String _buildTimeLabel(TimeRange? timeRange) {
    if (timeRange == null || timeRange.start == null || timeRange.end == null) {
      return 'No schedule';
    }

    final start = TimeOfDay.fromDateTime(timeRange.start!).format(context);
    final end = TimeOfDay.fromDateTime(timeRange.end!).format(context);
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final tasks = taskProvider.tasks;
    final completed = tasks.where((task) => task.isCompleted).length;
    final total = tasks.length;

    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space8),
            child: FloatingActionButton.extended(
              heroTag: 'start_focus',
              onPressed: tasks.isEmpty
                  ? null
                  : () => context.go(
                        '/session?duration=25',
                        extra: tasks.first,
                      ),
              label: const Text('Start Focus'),
              icon: const Icon(Icons.timer),
            ),
          ),
          FloatingActionButton(
            heroTag: 'add_task',
            onPressed: () => context.go('/task-create'),
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
              child: taskProvider.isLoading && tasks.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space16,
                      ),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskListItem(
                          title: task.title,
                          timeLabel: _buildTimeLabel(task.timeRange),
                          isCompleted: task.isCompleted,
                          onToggle: () => _toggleTask(task),
                          onTap: () => context.go('/task-detail/${task.id}'),
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
