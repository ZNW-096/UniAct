import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  const BodyText({
    super.key,
    required this.text,
    this.maxLines,
    this.textAlign = TextAlign.left,
    this.padding,
    this.color,
  });

  final String text;
  final int? maxLines;
  final TextAlign textAlign;
  final EdgeInsets? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final widget = Text(
      text,
      style: textTheme.bodyMedium?.copyWith(
        color: color ?? colorScheme.onSurface,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
      softWrap: true,
    );

    if (padding == null) return widget;

    return Padding(
      padding: padding!,
      child: widget,
    );
  }
}
