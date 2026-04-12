import 'package:live_activities/live_activities.dart';
import 'package:live_activities_usecase/match/match_entity.dart';
import 'package:live_activities_usecase/match/team_assets.dart';

// Service responsible for handling Live Activities
class LiveActivityService {
  // Plugin instance

  final LiveActivities _plugin = LiveActivities();
  // Initialize the plugin

  void init() {
    _plugin.init(appGroupId: 'group.com.youssef.liveactivities.4JV5D2RFJA');
  }
  // Start a new match live activity

  Future<String?> startMatch(MatchEntity match) async {
    await _plugin.endAllActivities();

    final data = {
      'matchName': 'World Cup Final ⚽️',
      ...match.toMap(),
      'teamAImageUrl': TeamAssets.psgLogoUrl,
      'teamBImageUrl': TeamAssets.chelseaLogoUrl,
    };

    print('🚀 Starting match with data: $data');

    final id = await _plugin.createActivity('football_match', data);

    print('🎯 Activity ID returned: $id');

    return id;
  }
  // Update an existing match activity

  Future<void> updateMatch(String id, MatchEntity match) async {
    await _plugin.updateActivity(id, match.toMap());
  }
  // Stop all live activities

  Future<void> stopMatch() async {
    await _plugin.endAllActivities();
  }
  // Check if live activities are supported on the device

  Future<bool> isSupported() async {
    return await _plugin.areActivitiesEnabled();
  }

  
  // Dispose plugin resources

  void dispose() {
    _plugin.dispose();
  }
}
