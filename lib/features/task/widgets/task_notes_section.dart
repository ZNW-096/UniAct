import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class TaskNotesSection extends StatelessWidget {
  const TaskNotesSection({
    super.key,
    required this.notes,
  });

  final String notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: 'Notes'),
          const SizedBox(height: AppSpacing.space16),
          BodyText(text: notes, maxLines: 5),
        ],
      ),
    );
  }
}
