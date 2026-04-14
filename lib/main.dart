import 'package:flutter/material.dart';
import 'package:live_activities_usecase/home/home_screen.dart';
import 'package:live_activities_usecase/live_activity/live_activity_service.dart';
import 'package:live_activities_usecase/match/match_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MatchProvider(LiveActivityService())..init(),
        ),
      ],
      child: const MaterialApp(home: HomeScreen()),
    );
  }
}
