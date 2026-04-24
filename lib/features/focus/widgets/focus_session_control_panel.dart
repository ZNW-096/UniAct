import 'package:flutter/material.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/theme/app_spacing.dart';

class FocusSessionControlPanel extends StatelessWidget {
  const FocusSessionControlPanel({
    super.key,
    required this.onStart,
    required this.onPauseResume,
    required this.onStop,
    required this.isRunning,
    required this.isPaused,
  });

  final VoidCallback onStart;
  final VoidCallback? onPauseResume;
  final VoidCallback onStop;
  final bool isRunning;
  final bool isPaused;

  String get _pauseResumeLabel {
    if (isRunning) {
      return 'Pause';
    }
    if (isPaused) {
      return 'Resume';
    }
    return 'Pause';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: AppSpacing.minTouchTarget,
            child: PrimaryButton(
              label: 'Start',
              onPressed: onStart,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          SizedBox(
            height: AppSpacing.minTouchTarget,
            child: PrimaryButton(
              label: _pauseResumeLabel,
              onPressed: onPauseResume,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          SizedBox(
            height: AppSpacing.minTouchTarget,
            child: OutlinedButton(
              onPressed: onStop,
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSpacing.radiusDefault),
                  ),
                ),
                minimumSize: const Size(
                  double.infinity,
                  AppSpacing.minTouchTarget,
                ),
              ),
              child: Text(
                'Stop',
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
