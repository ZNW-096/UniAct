import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/screens/home_screen.dart';
import 'features/focus/screens/focus_session_screen.dart';
import 'features/session/screens/session_end_screen.dart';
import 'features/task/screens/task_create_edit_screen.dart';
import 'features/task/screens/task_detail_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(
        completed: 2,
        total: 5,
        onToggle: (_) {},
        onTaskTap: (index) => context.go('/task-detail'),
        onAddTask: () => context.go('/task-create'),
        onStartFocus: () => context.go('/focus'),
        tasks: const [
          {
            'title': 'Revise Data Structures Notes',
            'timeLabel': '9:00 AM – 10:00 AM',
            'isCompleted': true,
          },
          {
            'title': 'Prepare Research Presentation',
            'timeLabel': '11:00 AM – 12:30 PM',
            'isCompleted': true,
          },
          {
            'title': 'Complete Database Normalization Exercise',
            'timeLabel': '2:00 PM – 3:00 PM',
            'isCompleted': false,
          },
          {
            'title': 'Read Chapter 5 – Operating Systems',
            'timeLabel': '4:00 PM – 5:00 PM',
            'isCompleted': false,
          },
          {
            'title': 'Submit Assignment on GitHub',
            'timeLabel': '6:00 PM – 6:30 PM',
            'isCompleted': false,
          },
        ],
      ),
    ),
    GoRoute(
      path: '/focus',
      builder: (context, state) => FocusSessionScreen(
        taskTitle: 'Complete Database Normalization Exercise',
        timerLabel: '25:00',
        onStartLong: () => context.go('/session-end'),
        onStartShort: () => context.go('/session-end'),
        onPause: () {},
        onStop: () => context.go('/session-end'),
      ),
    ),
    GoRoute(
      path: '/session-end',
      builder: (context, state) => SessionEndScreen(
        onRestart: () => context.go('/focus'),
        onBackHome: () => context.go('/'),
      ),
    ),
    GoRoute(
      path: '/task-create',
      builder: (context, state) => TaskCreateEditScreen(
        titleController: TextEditingController(),
        notesController: TextEditingController(),
        startTimeLabel: 'Select start time',
        endTimeLabel: 'Select end time',
        onSelectStart: () {},
        onSelectEnd: () {},
        onSave: () => context.go('/'),
        onCancel: () => context.go('/'),
      ),
    ),
    GoRoute(
      path: '/task-detail',
      builder: (context, state) => TaskDetailScreen(
        taskTitle: 'Complete Database Normalization Exercise',
        timeLabel: '2:00 PM – 3:00 PM',
        notes: 'Review lecture slides and complete the exercise sheet.',
        onStartFocus: () => context.go('/focus'),
        onComplete: () => context.go('/'),
      ),
    ),
  ],
);

void main() {
  runApp(const UniActApp());
}

class UniActApp extends StatelessWidget {
  const UniActApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Feature providers will be registered here as they are built.
        Provider<bool>.value(value: true),
      ],
      child: MaterialApp.router(
        title: 'UniAct – Do What Matters Today',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}
