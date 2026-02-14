import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/glass_container.dart';

import '../../core/localization/app_localization.dart';

import '../home_dashboard_screen/home_dashboard_screen.dart';
import '../tips_section_screen/tips_section_screen.dart';
import '../achievement_screen/achievement_screen.dart';
import '../leaderboard_screen/leaderboard_screen.dart';
import '../more_section_screen/more_section_screen.dart';

class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({Key? key}) : super(key: key);

  @override
  MainContainerScreenState createState() => MainContainerScreenState();
}

class MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboardScreen(), // Dashboard
    const TipsSectionScreen(), // Eco-Guide
    const AchievementScreen(), // Gamification
    const LeaderboardScreen(), // Leaderboard
    const MoreSectionScreen(), // Settings/Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Required for glass effect to show content behind
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: GlassContainer(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).cardColor.withValues(alpha: 0.8),
        blur: 15,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent, // Important for glass effect
          elevation: 0,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: AppLocalization().translate('dashboard'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              activeIcon: Icon(Icons.menu_book),
              label: AppLocalization().translate('guide'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              activeIcon: Icon(Icons.emoji_events),
              label: AppLocalization().translate('awards'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard),
              label: AppLocalization().translate('rank'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: AppLocalization().translate('settings'),
            ),
          ],
        ),
      ),
    );
  }
}
