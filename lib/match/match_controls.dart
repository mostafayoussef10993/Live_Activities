import 'package:flutter/material.dart';

// widget for match controls
class MatchControls extends StatelessWidget {
  final bool isMatchActive;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onCheckSupport;

  const MatchControls({
    super.key,
    required this.isMatchActive,
    required this.onStart,
    required this.onStop,
    required this.onCheckSupport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Start / Stop Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            //merged start and stop button in one button
            //and change the text and icon based on the match state
            onPressed: isMatchActive ? onStop : onStart,
            icon: Icon(isMatchActive ? Icons.stop : Icons.play_arrow),
            label: Text(isMatchActive ? 'Stop Match' : 'Start Match'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: isMatchActive ? Colors.red : Colors.green,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Check support button
        TextButton.icon(
          onPressed: onCheckSupport,
          icon: const Icon(Icons.info_outline),
          label: const Text('Check Support'),
        ),
      ],
    );
  }
}
