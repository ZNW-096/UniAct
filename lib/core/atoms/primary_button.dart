import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || isLoading;

    return Opacity(
      opacity: isLoading ? 0.5 : 1.0,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: (theme.elevatedButtonTheme.style ?? const ButtonStyle()).copyWith(
          minimumSize: const WidgetStatePropertyAll(
            Size(double.infinity, AppSpacing.minTouchTarget),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.onPrimary,
                constraints: const BoxConstraints.tightFor(
                  width: 18,
                  height: 18,
                ),
              )
            : Text(
                label,
                style: theme.textTheme.labelLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
