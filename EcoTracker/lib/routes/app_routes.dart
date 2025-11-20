import 'package:flutter/material.dart';
import '../presentation/achievement_screen/achievement_screen.dart';
import '../presentation/leaderboard_screen/leaderboard_screen.dart';
import '../presentation/progress_tracking_screen/progress_tracking_screen.dart';
import '../presentation/tips_section_screen/tips_section_screen.dart';
import '../presentation/more_section_screen/more_section_screen.dart';
import '../presentation/home_dashboard_screen/home_dashboard_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String achievement = '/achievement-screen';
  static const String leaderboard = '/leaderboard-screen';
  static const String progressTracking = '/progress-tracking-screen';
  static const String tipsSection = '/tips-section-screen';
  static const String moreSection = '/more-section-screen';
  static const String homeDashboard = '/home-dashboard-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const AchievementScreen(),
    achievement: (context) => const AchievementScreen(),
    leaderboard: (context) => const LeaderboardScreen(),
    progressTracking: (context) => const ProgressTrackingScreen(),
    tipsSection: (context) => const TipsSectionScreen(),
    moreSection: (context) => const MoreSectionScreen(),
    homeDashboard: (context) => const HomeDashboardScreen(),
    // TODO: Add your other routes here
  };
}
