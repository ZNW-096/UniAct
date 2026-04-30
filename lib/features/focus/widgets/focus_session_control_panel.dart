import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';

class FocusSessionControlPanel extends StatelessWidget {
  const FocusSessionControlPanel({
    super.key,
    required this.onPauseResume,
    required this.onStop,
    required this.isRunning,
    required this.isPaused,
  });

  final VoidCallback? onPauseResume;
  final VoidCallback onStop;
  final bool isRunning;
  final bool isPaused;

  IconData get _pauseResumeIcon {
    if (isPaused) {
      return Icons.play_arrow_rounded;
    }
    return Icons.pause_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final btnSize = (constraints.maxWidth * 0.25).clamp(56.0, 72.0);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: btnSize,
                height: btnSize,
                child: Tooltip(
                  message: isPaused ? 'Resume' : 'Pause',
                  child: FilledButton(
                    onPressed: onPauseResume,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                    ),
                    child: Icon(_pauseResumeIcon),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space16),
              SizedBox(
                width: btnSize,
                height: btnSize,
                child: Tooltip(
                  message: 'Stop',
                  child: FilledButton(
                    onPressed: onStop,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Icon(Icons.stop_rounded),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
