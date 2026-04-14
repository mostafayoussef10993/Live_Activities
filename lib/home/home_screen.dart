import 'package:flutter/material.dart';
import 'package:live_activities_usecase/match/match_controls.dart';
import 'package:live_activities_usecase/match/match_provider.dart';
import 'package:live_activities_usecase/match/match_score_section.dart';
import 'package:provider/provider.dart';

// Main UI screen using Provider
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to MatchProvider state
    final provider = context.watch<MatchProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activities')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show score section only if match is active
            if (provider.isMatchActive)
              MatchScoreSection(
                teamAScore: provider.teamAScore,
                teamBScore: provider.teamBScore,
                teamAName: provider.teamAName,
                teamBName: provider.teamBName,

                // Update scores via provider
                onTeamAScoreChanged: (score) =>
                    provider.updateScore(teamAScoreValue: score),

                onTeamBScoreChanged: (score) =>
                    provider.updateScore(teamBScoreValue: score),
              ),

            const SizedBox(height: 20),

            // Control buttons (start / stop / check support)
            MatchControls(
              isMatchActive: provider.isMatchActive,
              onStart: provider.startMatch,
              onStop: provider.stopMatch,
              onCheckSupport: () async {
                final supported = await provider.checkSupport();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(supported ? 'Supported' : 'Not supported'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
