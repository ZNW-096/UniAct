import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../models/task_model.dart';
import '../../../models/time_range.dart';
import '../providers/task_provider.dart';
import '../widgets/task_input_section.dart';
import '../widgets/time_selector_row.dart';
import '../widgets/form_action_section.dart';

class TaskCreateEditScreen extends StatefulWidget {
  const TaskCreateEditScreen({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  State<TaskCreateEditScreen> createState() => _TaskCreateEditScreenState();
}

class _TaskCreateEditScreenState extends State<TaskCreateEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _notesController;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _notesController = TextEditingController();
    final task = widget.task;
    if (task != null) {
      _titleController.text = task.title;
      _notesController.text = task.notes ?? '';
      _startTime = task.timeRange?.start;
      _endTime = task.timeRange?.end;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  String get _startTimeLabel => _formatTimeOrFallback(_startTime, 'Select start time');
  String get _endTimeLabel => _formatTimeOrFallback(_endTime, 'Select end time');

  String _formatTimeOrFallback(DateTime? dateTime, String fallback) {
    if (dateTime == null) {
      return fallback;
    }
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }

  DateTime _toDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  Future<void> _selectStart() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime != null
          ? TimeOfDay.fromDateTime(_startTime!)
          : TimeOfDay.now(),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _startTime = _toDateTime(picked);
    });
  }

  Future<void> _selectEnd() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime != null
          ? TimeOfDay.fromDateTime(_endTime!)
          : TimeOfDay.now(),
    );

    if (picked == null) {
      return;
    }

    setState(() {
      _endTime = _toDateTime(picked);
    });
  }

  Future<void> _saveTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }

    final notes = _notesController.text.trim();
    final task = Task(
      id: widget.task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      notes: notes.isEmpty ? null : notes,
      timeRange: _startTime == null && _endTime == null
          ? null
          : TimeRange(start: _startTime, end: _endTime),
      isCompleted: widget.task?.isCompleted ?? false,
    );

    if (widget.task == null) {
      await context.read<TaskProvider>().addTask(task);
    } else {
      await context.read<TaskProvider>().updateTask(task);
    }
    if (!mounted) {
      return;
    }
    context.go('/home');
  }

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
                titleController: _titleController,
                notesController: _notesController,
              ),
              const SizedBox(height: AppSpacing.space16),
              TimeSelectorRow(
                startTimeLabel: _startTimeLabel,
                endTimeLabel: _endTimeLabel,
                onSelectStart: _selectStart,
                onSelectEnd: _selectEnd,
              ),
              const SizedBox(height: AppSpacing.space24),
              FormActionSection(
                onSave: _saveTask,
                onCancel: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
