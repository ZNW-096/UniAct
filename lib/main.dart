import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/focus/providers/focus_session_provider.dart';
import 'features/task/providers/task_provider.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/focus_session_service.dart';
import 'services/task_service.dart';

final _router = buildAppRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UniActRoot());
}

class UniActRoot extends StatelessWidget {
  const UniActRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(authService: AuthService()),
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(taskService: TaskService()),
        ),
        ChangeNotifierProvider<FocusSessionProvider>(
          create: (_) => FocusSessionProvider(
            focusSessionService: FocusSessionService(),
          ),
        ),
      ],
      child: const AppInitializer(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthProvider>().signInAnonymously();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final isAuthReady = !authProvider.isLoading && authProvider.userId != null;
    if (!isAuthReady) {
      return const _StartupGate();
    }

    return const UniActApp();
  }
}

class UniActApp extends StatelessWidget {
  const UniActApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniAct – Do What Matters Today',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}

class _StartupGate extends StatelessWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
