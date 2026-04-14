// Provider responsible for managing match state and logic
import 'package:flutter/material.dart';
import 'package:live_activities_usecase/live_activity/live_activity_service.dart';
import 'package:live_activities_usecase/match/match_entity.dart';
import 'package:permission_handler/permission_handler.dart';

class MatchProvider extends ChangeNotifier {
  final LiveActivityService _service;

  MatchProvider(this._service);

  String? activityId; // Current activity ID
  bool permissionGranted = false; // Notification permission

  // Scores
  int teamAScore = 0;
  int teamBScore = 0;

  // Team names
  final String teamAName = 'PSG';
  final String teamBName = 'Chelsea';

  // Check if match is active
  bool get isMatchActive => activityId != null;

  // Initialize provider
  Future<void> init() async {
    _service.init();
    await _requestPermission();
  }

  // Request notification permission
  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();
    permissionGranted = status.isGranted;
    notifyListeners();
  }

  // Build match entity
  MatchEntity _buildMatch() {
    return MatchEntity(
      teamAName: teamAName,
      teamBName: teamBName,
      teamAScore: teamAScore,
      teamBScore: teamBScore,
    );
  }

  // Start match
  Future<void> startMatch() async {
    if (!permissionGranted) return;

    final id = await _service.startMatch(_buildMatch());
    activityId = id;
    notifyListeners();
  }

  // Update score
  Future<void> updateScore({int? teamAScoreValue, int? teamBScoreValue}) async {
    if (teamAScoreValue != null) teamAScore = teamAScoreValue;
    if (teamBScoreValue != null) teamBScore = teamBScoreValue;

    // Update live activity if active
    if (activityId != null) {
      await _service.updateMatch(activityId!, _buildMatch());
    }

    notifyListeners();
  }

  // Stop match
  Future<void> stopMatch() async {
    await _service.stopMatch();
    activityId = null;
    notifyListeners();
  }

  // Check if live activities are supported
  Future<bool> checkSupport() async {
    return await _service.isSupported();
  }

  // Dispose service
  void disposeService() {
    _service.dispose();
  }
}
