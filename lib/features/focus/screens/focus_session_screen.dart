import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/responsive_body.dart';
import '../../../models/task_model.dart';
import '../providers/focus_session_provider.dart';
import '../widgets/focus_session_control_panel.dart';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({
    super.key,
    required this.task,
    required this.durationMinutes,
  });

  final Task task;
  final int durationMinutes;

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  bool _navigatedToSessionEnd = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<FocusSessionProvider>()
          .startSession(widget.task, widget.durationMinutes);
    });
  }

  String _formatRemainingSeconds(int remainingSeconds) {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double _calculateProgress({
    required int remainingSeconds,
    required int totalSeconds,
  }) {
    if (totalSeconds <= 0) {
      return 0;
    }
    final progress = remainingSeconds / totalSeconds;
    return progress.clamp(0, 1).toDouble();
  }

  VoidCallback? _pauseResumeAction(FocusSessionProvider provider) {
    if (provider.isRunning) {
      return context.read<FocusSessionProvider>().pauseSession;
    }
    if (provider.isPaused) {
      return context.read<FocusSessionProvider>().resumeSession;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<FocusSessionProvider>();
    final progress = _calculateProgress(
      remainingSeconds: provider.remainingSeconds,
      totalSeconds: provider.totalSeconds,
    );

    if (provider.isCompleted && !_navigatedToSessionEnd) {
      _navigatedToSessionEnd = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        context.go('/session-end');
      });
    }

    return Scaffold(
      body: SafeArea(
        child: ResponsiveBody(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final timerSize = (constraints.maxWidth * 0.7).clamp(140.0, 240.0);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: timerSize,
                            height: timerSize,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: timerSize,
                            height: timerSize,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 10,
                            ),
                          ),
                          SizedBox(
                            width: timerSize * 0.8,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.center,
                              child: Text(
                                _formatRemainingSeconds(provider.remainingSeconds),
                                style: theme.textTheme.headlineLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.space32),
                      FocusSessionControlPanel(
                        onPauseResume: _pauseResumeAction(provider),
                        onStop: () {
                          context.read<FocusSessionProvider>().stopSession();
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/home');
                          }
                        },
                        isRunning: provider.isRunning,
                        isPaused: provider.isPaused,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
