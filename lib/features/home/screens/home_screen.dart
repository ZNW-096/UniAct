import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/task_model.dart';
import '../../../models/time_range.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/state/async_state.dart';
import '../../auth/providers/auth_provider.dart';
import '../../task/providers/task_provider.dart';
import '../widgets/today_progress_section.dart';
import '../widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _confirmAndDeleteData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete your data permanently?'),
          content: const Text(
            'This will permanently remove your tasks, focus sessions, and account data. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              child: const Text('Delete permanently'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.deleteMyDataAndAccount();
    if (!mounted || success) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          authProvider.errorMessage ??
              'Could not delete your data. Please try again.',
        ),
      ),
    );
  }

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
      userId: task.userId,
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
    final taskStatus = taskProvider.listStatus;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete_data') {
                _confirmAndDeleteData();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(
                value: 'delete_data',
                child: Text('Delete my data'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add_task',
            onPressed: () => context.go('/task-create'),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TodayProgressSection(
                  completed: completed,
                  total: total,
                ),
                const SizedBox(height: AppSpacing.space8),
                Expanded(
              child: taskStatus == AsyncStatus.loading && tasks.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : taskStatus == AsyncStatus.error && tasks.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.space24,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  taskProvider.listErrorMessage ?? 'Error loading tasks',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: AppSpacing.space16),
                                ElevatedButton(
                                  onPressed: taskProvider.listenToTasks,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : tasks.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.space24,
                                ),
                                child: Text(
                                  'No tasks yet. Tap + to create your first task.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            )
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
        ),
      ),
    );
  }
}
