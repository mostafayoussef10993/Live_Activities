import 'package:flutter/material.dart';
import 'package:live_activities_usecase/match/match_controls.dart';
import 'package:live_activities_usecase/match/match_score_section.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../live_activity/live_activity_service.dart';
import '../../match/match_entity.dart';

// Main screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Live activity service

  final LiveActivityService _service = LiveActivityService();
  // Current activity ID

  String? _activityId;
  // Notification permission
  bool _permissionGranted = false;

  int teamAScore = 0;
  int teamBScore = 0;

  final String teamAName = 'PSG';
  final String teamBName = 'Chelsea';

  @override
  void initState() {
    super.initState();
    // Initialize service
    _service.init();
    // Request notification permission
    _requestPermission();
  }
  // Request notification permission

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    setState(() => _permissionGranted = status.isGranted);
  }

  @override
  void dispose() {
    // Clean resources
    _service.dispose();
    super.dispose();
  }
  // Build match entity from current state

  MatchEntity _buildMatch() {
    return MatchEntity(
      teamAName: teamAName,
      teamBName: teamBName,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
    );
  }
  // Start match

  Future<void> _startMatch() async {
    if (!_permissionGranted) return;
    final id = await _service.startMatch(_buildMatch());
    setState(() => _activityId = id);
  }
  // Update scores

  Future<void> _updateScore() async {
    if (_activityId == null) return;
    await _service.updateMatch(_activityId!, _buildMatch());
  }
  // Stop match

  Future<void> _stopMatch() async {
    await _service.stopMatch();
    setState(() => _activityId = null);
  }
  // Check support

  void _checkSupport() async {
    final supported = await _service.isSupported();
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(supported ? 'Supported' : 'Not supported')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isActive = _activityId != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activities')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show score section only if match is active
            if (isActive)
              MatchScoreSection(
                teamAScore: teamAScore,
                teamBScore: teamBScore,
                teamAName: teamAName,
                teamBName: teamBName,
                onTeamAScoreChanged: (score) {
                  setState(() => teamAScore = score);
                  _updateScore();
                },
                onTeamBScoreChanged: (score) {
                  setState(() => teamBScore = score);
                  _updateScore();
                },
              ),

            const SizedBox(height: 20),

            // Control buttons (start / stop / check)
            MatchControls(
              isMatchActive: isActive,
              onStart: _startMatch,
              onStop: _stopMatch,
              onCheckSupport: _checkSupport,
            ),
          ],
        ),
      ),
    );
  }
}
