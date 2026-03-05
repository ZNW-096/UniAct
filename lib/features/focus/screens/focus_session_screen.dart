import 'package:flutter/material.dart';
import '../widgets/active_task_header.dart';
import '../widgets/focus_session_control_panel.dart';
import '../widgets/focus_action_row.dart';

class FocusSessionScreen extends StatelessWidget {
  const FocusSessionScreen({
    super.key,
    required this.taskTitle,
    required this.timerLabel,
    required this.onStartLong,
    required this.onStartShort,
    required this.onPause,
    required this.onStop,
  });

  final String taskTitle;
  final String timerLabel;
  final VoidCallback onStartLong;
  final VoidCallback onStartShort;
  final VoidCallback onPause;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ActiveTaskHeader(taskTitle: taskTitle),
            const Spacer(),
            FocusSessionControlPanel(
              timerLabel: timerLabel,
              onStartLong: onStartLong,
              onStartShort: onStartShort,
            ),
            const Spacer(),
            FocusActionRow(
              onPause: onPause,
              onStop: onStop,
            ),
          ],
        ),
      ),
    );
  }
}
