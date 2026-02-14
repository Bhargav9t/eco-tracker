import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../theme/app_theme.dart';
import '../../widgets/visual_effects.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Achievements')),
      body: GridView.count(
        padding: EdgeInsets.all(4.w),
        crossAxisCount: 2,
        mainAxisSpacing: 4.w,
        crossAxisSpacing: 4.w,
        children: [
          _buildBadge(context, 'First Tree', 'Planted 1 tree', Icons.park, AppTheme.ecoGreen, true, 100),
          _buildBadge(context, 'Week Streak', '7 days active', Icons.local_fire_department, AppTheme.fireOrange, true, 200),
          _buildBadge(context, 'Recycler', '10 items recycled', Icons.delete_outline, AppTheme.skyBlue, false, 300),
          _buildBadge(context, 'Vegan', '5 meat-free meals', Icons.restaurant_menu, AppTheme.rosePink, false, 400),
          _buildBadge(context, 'Cyclist', '10km cycled', Icons.directions_bike, AppTheme.rubberDuckYellow, false, 500),
          _buildBadge(context, 'Saver', 'Energy saved', Icons.bolt, AppTheme.rubberDuckYellow, false, 600),
        ],
      ),
    );
  }

  Widget _buildBadge(
      BuildContext context, String title, String subtitle, IconData icon, Color color, bool unlocked, int delay) {
    return FadeInSlide(
      delay: Duration(milliseconds: delay),
      child: BouncyWrapper(
        onTap: () {
          // Show details
        },
        child: Card(
          color: unlocked ? AppTheme.featherWhite : AppTheme.polarSnow,
          elevation: unlocked ? 2 : 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unlocked ? color.withValues(alpha: 0.1) : AppTheme.hareGray.withValues(alpha: 0.2),
                ),
                child: Icon(
                  icon,
                  size: 30.sp,
                  color: unlocked ? color : AppTheme.hareGray,
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: unlocked ? AppTheme.wolfGray : AppTheme.hareGray,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: unlocked ? AppTheme.wolfGray.withValues(alpha: 0.7) : AppTheme.hareGray,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
