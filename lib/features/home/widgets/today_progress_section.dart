import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/app_progress_indicator.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class TodayProgressSection extends StatelessWidget {
  const TodayProgressSection({
    super.key,
    required this.completed,
    required this.total,
  });

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: "Today's Progress"),
          const SizedBox(height: AppSpacing.space16),
          AppProgressIndicator(
            completed: completed,
            total: total,
          ),
          const SizedBox(height: AppSpacing.space8),
          const BodyText(
            text: 'Stay consistent. Small wins build momentum.',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
