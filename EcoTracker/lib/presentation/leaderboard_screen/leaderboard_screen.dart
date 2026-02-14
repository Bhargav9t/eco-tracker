import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../theme/app_theme.dart';
import '../../widgets/visual_effects.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: ListView(
        padding: EdgeInsets.all(4.w),
        children: [
          FadeInSlide(delay: Duration(milliseconds: 100), child: _buildTopThree(context)),
          SizedBox(height: 3.h),
          _buildUserItem(4, 'Sarah Palmer', '1,250 XP', false, 300),
          _buildUserItem(5, 'Mike Chen', '1,100 XP', false, 400),
          _buildUserItem(6, 'You', '950 XP', true, 500),
          _buildUserItem(7, 'Emma Watson', '900 XP', false, 600),
          _buildUserItem(8, 'David Miller', '850 XP', false, 700),
        ],
      ),
    );
  }

  Widget _buildTopThree(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildPodium(context, '2', 'Silver', AppTheme.hareGray, 120),
        _buildPodium(context, '1', 'Gold', AppTheme.rubberDuckYellow, 160),
        _buildPodium(context, '3', 'Bronze', AppTheme.fireOrange, 100),
      ],
    );
  }

  Widget _buildPodium(BuildContext context, String rank, String name, Color color, double height) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 20.sp,
          child: Text(rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp)),
        ),
        SizedBox(height: 1.h),
        Container(
          width: 20.w,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            border: Border.all(color: color, width: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildUserItem(int rank, String name, String xp, bool isMe, int delay) {
    return FadeInSlide(
      delay: Duration(milliseconds: delay),
      child: Card(
        color: isMe ? AppTheme.ecoGreen.withValues(alpha: 0.1) : AppTheme.featherWhite,
        margin: EdgeInsets.only(bottom: 1.h),
        child: ListTile(
          leading: Text(
            '#$rank',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          title: Text(name, style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
          trailing: Text(xp, style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.skyBlue)),
        ),
      ),
    );
  }
}
