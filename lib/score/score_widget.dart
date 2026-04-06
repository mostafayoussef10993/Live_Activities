import 'package:flutter/material.dart';
// A widget to display the score of a team
// with buttons to increase and decrease score

class ScoreWidget extends StatelessWidget {
  final int score;
  final String teamName;
  final ValueChanged<int> onScoreChanged;

  const ScoreWidget({
    super.key,
    required this.score,
    required this.teamName,
    required this.onScoreChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Team Name
            Text(
              teamName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            // Score
            Text(
              '$score',
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ScoreButton(
                  icon: Icons.remove,
                  onTap: () => onScoreChanged(score > 0 ? score - 1 : 0),
                ),
                const SizedBox(width: 16),
                _ScoreButton(
                  icon: Icons.add,
                  onTap: () => onScoreChanged(score + 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// A private class  for the score button
class _ScoreButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ScoreButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: 20),
      ),
    );
  }
}
