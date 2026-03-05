import 'package:flutter/material.dart';
import '../widgets/session_summary_card.dart';
import '../widgets/session_action_panel.dart';

class SessionEndScreen extends StatelessWidget {
  const SessionEndScreen({
    super.key,
    required this.onRestart,
    required this.onBackHome,
  });

  final VoidCallback onRestart;
  final VoidCallback onBackHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            SessionSummaryCard(
              focusDuration: 'You focused for 25 minutes.',
              motivationMessage: 'Great discipline today.',
            ),
            const Spacer(),
            SessionActionPanel(
              onRestart: onRestart,
              onBackHome: onBackHome,
            ),
          ],
        ),
      ),
    );
  }
}
