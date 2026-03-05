import 'package:flutter/material.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/atoms/app_text_field.dart';
import '../../../core/atoms/body_text.dart';
import '../../../core/theme/app_spacing.dart';

class TaskInputSection extends StatelessWidget {
  const TaskInputSection({
    super.key,
    required this.titleController,
    required this.notesController,
  });

  final TextEditingController titleController;
  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SectionTitle(title: 'Task Details'),
          const SizedBox(height: AppSpacing.space16),
          AppTextField(
            controller: titleController,
            hintText: 'Complete database normalization notes',
          ),
          const SizedBox(height: AppSpacing.space16),
          AppTextField(
            controller: notesController,
            hintText: 'Optional notes',
            maxLines: 3,
          ),
          const SizedBox(height: AppSpacing.space8),
          const BodyText(
            text: 'Be specific. Clear tasks improve focus.',
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
