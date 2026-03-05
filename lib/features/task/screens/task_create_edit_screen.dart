import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';
import '../widgets/task_input_section.dart';
import '../widgets/time_selector_row.dart';
import '../widgets/form_action_section.dart';

class TaskCreateEditScreen extends StatelessWidget {
  const TaskCreateEditScreen({
    super.key,
    required this.titleController,
    required this.notesController,
    required this.startTimeLabel,
    required this.endTimeLabel,
    required this.onSelectStart,
    required this.onSelectEnd,
    required this.onSave,
    required this.onCancel,
  });

  final TextEditingController titleController;
  final TextEditingController notesController;
  final String startTimeLabel;
  final String endTimeLabel;
  final VoidCallback onSelectStart;
  final VoidCallback onSelectEnd;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TaskInputSection(
                titleController: titleController,
                notesController: notesController,
              ),
              const SizedBox(height: AppSpacing.space16),
              TimeSelectorRow(
                startTimeLabel: startTimeLabel,
                endTimeLabel: endTimeLabel,
                onSelectStart: onSelectStart,
                onSelectEnd: onSelectEnd,
              ),
              const SizedBox(height: AppSpacing.space24),
              FormActionSection(
                onSave: onSave,
                onCancel: onCancel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
