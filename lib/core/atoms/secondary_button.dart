import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isDisabled = onPressed == null;

    return Opacity(
      opacity: isDisabled ? 0.6 : 1.0,
      child: IgnorePointer(
        ignoring: isDisabled,
        child: OutlinedButton(
          onPressed: onPressed ?? () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, AppSpacing.minTouchTarget),
            foregroundColor: primary,
            side: BorderSide(color: primary, width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusDefault),
            ),
            textStyle: theme.textTheme.labelLarge,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
