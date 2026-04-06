import 'package:flutter/material.dart';

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
        if (!isMatchActive)
          TextButton(onPressed: onStart, child: const Text('Start Match')),

        if (isMatchActive)
          TextButton(onPressed: onStop, child: const Text('Stop Match')),

        TextButton(
          onPressed: onCheckSupport,
          child: const Text('Check Support'),
        ),
      ],
    );
  }
}
