import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/atoms/body_text.dart';
import '../../../core/atoms/primary_button.dart';
import '../../../core/atoms/section_title.dart';
import '../../../core/theme/app_spacing.dart';
import '../../focus/providers/focus_session_provider.dart';

class SessionEndScreen extends StatelessWidget {
  const SessionEndScreen({super.key});

  String _buildDurationLabel(int durationMinutes) {
    return 'Duration: $durationMinutes minutes';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FocusSessionProvider>();
    final durationMinutes = provider.currentSession?.durationMinutes ?? 0;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SectionTitle(title: 'Session Completed'),
                  const SizedBox(height: AppSpacing.space16),
                  BodyText(
                    text: _buildDurationLabel(durationMinutes),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: PrimaryButton(
                label: 'Back to Home',
                onPressed: () => context.go('/home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
