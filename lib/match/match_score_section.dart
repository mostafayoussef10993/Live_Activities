import 'package:flutter/material.dart';
import '../../score/score_widget.dart';

class MatchScoreSection extends StatelessWidget {
  final int teamAScore;
  final int teamBScore;
  final String teamAName;
  final String teamBName;
  final Function(int) onTeamAScoreChanged;
  final Function(int) onTeamBScoreChanged;

  const MatchScoreSection({
    super.key,
    required this.teamAScore,
    required this.teamBScore,
    required this.teamAName,
    required this.teamBName,
    required this.onTeamAScoreChanged,
    required this.onTeamBScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScoreWidget(
            score: teamAScore,
            teamName: teamAName,
            onScoreChanged: onTeamAScoreChanged,
          ),
        ),
        Expanded(
          child: ScoreWidget(
            score: teamBScore,
            teamName: teamBName,
            onScoreChanged: onTeamBScoreChanged,
          ),
        ),
      ],
    );
  }
}
