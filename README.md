📱 Live Activities Match Tracker (Flutter)

A modern Flutter application that demonstrates how to integrate Live Activities to display and update a real-time football match score directly on the device.

This project showcases clean architecture, state management using Provider, and real-time updates using native platform capabilities.

🚀 Features
⚽ Start a live football match
🔄 Real-time score updates
🛑 Stop live activity
📲 Check device support for Live Activities
🔔 Notification permission handling
🧩 Clean and modular UI components
🧠 State management using Provider
🏗️ Architecture

This project follows a clean and scalable architecture:

UI (Widgets)
   ↓
MatchProvider (State Management)
   ↓
LiveActivityService (Business Logic / Platform Layer)
   ↓
Live Activities Plugin (Native)
Layers Explained:
UI Layer
HomeScreen
MatchScoreSection
MatchControls
State Management
MatchProvider (handles state + logic)
Domain Layer
MatchEntity (data model)
Data Layer
LiveActivityService (plugin communication)
📂 Project Structure
lib/
│
├── data/
│   └── live_activity_service.dart
│
├── domain/
│   └── match_entity.dart
│
├── match/
│   ├── match_provider.dart
│   ├── match_controls.dart
│   ├── match_score_section.dart
│
├── score/
│   └── score_widget.dart
│
├── presentation/
│   └── home_screen.dart
│
└── main.dart
🧠 State Management

The app uses Provider for state management:

Centralized logic inside MatchProvider
UI listens using context.watch
Updates handled via notifyListeners()
📸 How It Works
1. Start Match
Requests notification permission
Creates a live activity
Displays score UI
2. Update Score
User increments/decrements score
Updates provider state
Sends update to Live Activity
3. Stop Match
Ends live activity
Resets state
🛠️ Tech Stack
Flutter
Dart
Provider (State Management)
Live Activities Plugin
Permission Handler
⚙️ Setup & Installation
1. Clone the repository
git clone https://github.com/mostafayoussef10993/Live-Activities-Match-Tracker
cd live-activities-app
2. Install dependencies
flutter pub get
3. Run the app
flutter run
⚠️ Important Notes
Live Activities are platform-dependent (mainly iOS)
You may need:
Proper iOS configuration
App Group setup
Notification permission is required
🔥 Key Learning Points

This project demonstrates:

Clean Architecture in Flutter
Separation of concerns
Provider state management
Real-time UI updates
Plugin integration with native features
🚀 Future Improvements
⏱️ Match timer support
🏆 Multiple matches tracking
🌐 API integration (real match data)
🎨 Enhanced UI/UX
📊 Match statistics
🔔 Push notifications integration
