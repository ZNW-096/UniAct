import 'package:flutter/material.dart';
import '../../../core/atoms/app_icon_button.dart';
import '../../../core/theme/app_spacing.dart';

class FocusActionRow extends StatelessWidget {
  const FocusActionRow({
    super.key,
    required this.onPause,
    required this.onStop,
  });

  final VoidCallback onPause;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppIconButton(
            icon: Icons.pause,
            onTap: onPause,
            semanticLabel: 'Pause focus session',
          ),
          AppIconButton(
            icon: Icons.stop,
            onTap: onStop,
            semanticLabel: 'Stop focus session',
          ),
        ],
      ),
    );
  }
}
