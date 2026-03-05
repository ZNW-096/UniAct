import 'package:flutter/material.dart';
import '../theme/app_spacing.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

  static const double _size = 48.0;
  static const _radius = BorderRadius.all(Radius.circular(AppSpacing.radiusLarge));

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: semanticLabel,
      button: true,
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: _radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: _radius,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
