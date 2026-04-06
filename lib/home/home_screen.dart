import 'package:flutter/material.dart';
import 'package:live_activities_usecase/live_activity/live_activity_service.dart';
import 'package:live_activities_usecase/match/match_entity.dart';
import 'package:live_activities_usecase/score/score_widget.dart';
import 'package:permission_handler/permission_handler.dart';

// Main screen of the app

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Service to handle live activities

  final LiveActivityService _service = LiveActivityService();

  String? _activityId; // Current activity ID
  bool _permissionGranted = false;
  // Starting Scores

  int teamAScore = 0;
  int teamBScore = 0;
  // Team names

  final String teamAName = 'PSG';
  final String teamBName = 'Chelsea';

  @override
  void initState() {
    super.initState();
    _service.init(); // Initialize service
    _requestPermission(); // Ask for notification permission
  }
  // Request notification permission

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    setState(() => _permissionGranted = status.isGranted);
  }

  @override
  void dispose() {
    _service.dispose(); // Clean resources
    super.dispose();
  }
  // Build match object from current data

  MatchEntity _buildMatch() {
    return MatchEntity(
      teamAName: teamAName,
      teamBName: teamBName,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
    );
  }
  // Start live match

  Future<void> _startMatch() async {
    if (!_permissionGranted) return;

    final id = await _service.startMatch(_buildMatch());
    setState(() => _activityId = id);
  }
  // Update match score

  Future<void> _updateScore() async {
    if (_activityId == null) return;
    await _service.updateMatch(_activityId!, _buildMatch());
  }
  // Stop match

  Future<void> _stopMatch() async {
    await _service.stopMatch();
    setState(() => _activityId = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Activities')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show scores only if match is active
          if (_activityId != null)
            Row(
              children: [
                Expanded(
                  child: ScoreWidget(
                    score: teamAScore,
                    teamName: teamAName,
                    onScoreChanged: (score) {
                      setState(() => teamAScore = score);
                      _updateScore(); // Update live activity
                    },
                  ),
                ),
                Expanded(
                  child: ScoreWidget(
                    score: teamBScore,
                    teamName: teamBName,
                    onScoreChanged: (score) {
                      setState(() => teamBScore = score);
                      _updateScore();
                    },
                  ),
                ),
              ],
            ),

          const SizedBox(height: 20),

          // Start match button
          if (_activityId == null)
            TextButton(
              onPressed: _startMatch,
              child: const Text('Start Match'),
            ),

          // Stop match button
          if (_activityId != null)
            TextButton(onPressed: _stopMatch, child: const Text('Stop Match')),

          // Check support button
          TextButton(
            onPressed: () async {
              final supported = await _service.isSupported();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(supported ? 'Supported' : 'Not supported'),
                ),
              );
            },
            child: const Text('Check Support'),
          ),
        ],
      ),
    );
  }
}
