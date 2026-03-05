import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/atoms/app_icon_button.dart';
import '../../../core/theme/app_spacing.dart';

class TimeSelectorRow extends StatelessWidget {
  const TimeSelectorRow({
    super.key,
    required this.startTimeLabel,
    required this.endTimeLabel,
    required this.onSelectStart,
    required this.onSelectEnd,
  });

  final String startTimeLabel;
  final String endTimeLabel;
  final VoidCallback onSelectStart;
  final VoidCallback onSelectEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: 'Schedule (Optional)'),
          const SizedBox(height: AppSpacing.space16),
          Row(
            children: [
              Expanded(
                child: BodyText(text: startTimeLabel, maxLines: 1),
              ),
              const SizedBox(width: AppSpacing.space8),
              AppIconButton(
                icon: Icons.access_time,
                onTap: onSelectStart,
                semanticLabel: 'Select start time',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Row(
            children: [
              Expanded(
                child: BodyText(text: endTimeLabel, maxLines: 1),
              ),
              const SizedBox(width: AppSpacing.space8),
              AppIconButton(
                icon: Icons.access_time,
                onTap: onSelectEnd,
                semanticLabel: 'Select end time',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
