import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/focus/screens/focus_session_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/session/screens/session_end_screen.dart';
import '../../features/task/providers/task_provider.dart';
import '../../features/task/screens/task_create_edit_screen.dart';
import '../../features/task/screens/task_detail_screen.dart';
import '../../models/task_model.dart';
import '../navigation/main_shell.dart';

GoRouter buildAppRouter() {
	return GoRouter(
		initialLocation: '/home',
		routes: [
			GoRoute(
				path: '/',
				redirect: (context, state) => '/home',
			),
			ShellRoute(
				builder: (context, state, child) => MainShell(child: child),
				routes: [
					GoRoute(
						path: '/home',
						builder: (context, state) => const HomeScreen(),
					),
					GoRoute(
						path: '/session',
						builder: (context, state) {
							final task = state.extra as Task? ??
									(context.read<TaskProvider>().tasks.isNotEmpty
											? context.read<TaskProvider>().tasks.first
											: null);

							if (task == null) {
								return const SafeArea(
									child: Center(
										child: Text('No task available to start focus session.'),
									),
								);
							}

							return FocusSessionScreen(
								task: task,
								durationMinutes:
										int.tryParse(state.uri.queryParameters['duration'] ?? '') ??
												25,
							);
						},
					),
				],
			),
			GoRoute(
				path: '/session-end',
				builder: (context, state) => const SessionEndScreen(),
			),
			GoRoute(
				path: '/task-create',
				builder: (context, state) => TaskCreateEditScreen(
					task: state.extra as Task?,
				),
			),
			GoRoute(
				path: '/task-detail/:id',
				builder: (context, state) => TaskDetailScreen(
					taskId: state.pathParameters['id'] ?? '',
				),
			),
		],
	);
}
