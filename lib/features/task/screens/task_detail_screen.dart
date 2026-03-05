import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/task_detail_header.dart';
import '../widgets/task_notes_section.dart';
import '../widgets/task_action_panel.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskTitle,
    required this.timeLabel,
    required this.notes,
    required this.onStartFocus,
    required this.onComplete,
  });

  final String taskTitle;
  final String timeLabel;
  final String notes;
  final VoidCallback onStartFocus;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TaskDetailHeader(
              taskTitle: taskTitle,
              timeLabel: timeLabel,
            ),
            const SizedBox(height: AppSpacing.space16),
            TaskNotesSection(notes: notes),
            const Spacer(),
            TaskActionPanel(
              onStartFocus: onStartFocus,
              onComplete: onComplete,
            ),
          ],
        ),
      ),
    );
  }
}
