import 'package:flutter/material.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/achievement_screen/achievement_screen.dart';
import '../presentation/leaderboard_screen/leaderboard_screen.dart';
import '../presentation/progress_tracking_screen/progress_tracking_screen.dart';
import '../presentation/tips_section_screen/tips_section_screen.dart';
import '../presentation/more_section_screen/more_section_screen.dart';
import '../presentation/home_dashboard_screen/home_dashboard_screen.dart';
import '../presentation/main_container_screen/main_container_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String loginScreen = '/login_screen';
  static const String mainContainerScreen = '/main_container_screen';
  static const String achievement = '/achievement-screen';
  static const String leaderboard = '/leaderboard-screen';
  static const String progressTracking = '/progress-tracking-screen';
  static const String tipsSection = '/tips-section-screen';
  static const String moreSection = '/more-section-screen';
  static const String homeDashboard = '/home-dashboard-screen';

  static Map<String, WidgetBuilder> get routes => {
    initial: (context) => const MainContainerScreen(), // Assuming initial should point to MainContainerScreen
    loginScreen: (context) => LoginScreen(),
    mainContainerScreen: (context) => MainContainerScreen(),
    achievement: (context) => AchievementScreen(),
    leaderboard: (context) => LeaderboardScreen(),
    progressTracking: (context) => ProgressTrackingScreen(),
    tipsSection: (context) => TipsSectionScreen(),
    moreSection: (context) => MoreSectionScreen(),
    homeDashboard: (context) => HomeDashboardScreen(),
    // TODO: Add your other routes here
  };
}
