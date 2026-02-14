import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../theme/app_theme.dart';
import '../../core/data/mock_database.dart';
import '../../core/localization/app_localization.dart';
import '../../routes/app_routes.dart';

class MoreSectionScreen extends StatefulWidget {
  const MoreSectionScreen({Key? key}) : super(key: key);

  @override
  _MoreSectionScreenState createState() => _MoreSectionScreenState();
}

class _MoreSectionScreenState extends State<MoreSectionScreen> {
  bool _notificationsEnabled = true;

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Language'),
        children: [
          SimpleDialogOption(
            onPressed: () { AppLocalization().setLocale('en'); Navigator.pop(context); },
            child: Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () { AppLocalization().setLocale('es'); Navigator.pop(context); },
            child: Text('Español'),
          ),
          SimpleDialogOption(
            onPressed: () { AppLocalization().setLocale('fr'); Navigator.pop(context); },
            child: Text('Français'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalization().translate('settings'))),
      body: ListView(
        padding: EdgeInsets.all(4.w),
        children: [
          _buildProfileCard(context),
          SizedBox(height: 3.h),
          Text('Preferences', style: Theme.of(context).textTheme.titleMedium), // Keep 'Preferences' hardcoded or add to map if needed, map didn't have it
          SizedBox(height: 1.h),
          _buildSettingItem(
            icon: Icons.notifications_outlined,
            title: AppLocalization().translate('notifications'),
            value: _notificationsEnabled,
            onChanged: (v) => setState(() => _notificationsEnabled = v),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: MockDatabase().isDarkMode,
            builder: (context, isDark, _) {
              return _buildSettingItem(
                icon: Icons.dark_mode_outlined,
                title: AppLocalization().translate('dark_mode'),
                value: isDark,
                onChanged: (v) => MockDatabase().toggleTheme(),
              );
            },
          ),
          ValueListenableBuilder<Locale>(
            valueListenable: AppLocalization().currentLocale,
            builder: (context, locale, _) {
              return _buildSettingItem(
                icon: Icons.language, 
                title: AppLocalization().translate('language'), 
                trailingText: locale.languageCode.toUpperCase(),
                onTap: () {
                  _showLanguageDialog(context);
                },
              );
            },
          ),
          SizedBox(height: 3.h),
          Text('Support', style: Theme.of(context).textTheme.titleMedium), // Hardcoded 'Support'
          SizedBox(height: 1.h),
          _buildSettingItem(icon: Icons.help_outline, title: AppLocalization().translate('help_center'), onTap: () {}),
          _buildSettingItem(icon: Icons.info_outline, title: AppLocalization().translate('about'), onTap: () {}),
          SizedBox(height: 3.h),
          OutlinedButton(
            onPressed: () async {
              await MockDatabase().logout();
              Navigator.pushNamedAndRemoveUntil(
                context, 
                AppRoutes.loginScreen, 
                (route) => false,
              );
            },
            child: Text(AppLocalization().translate('logout')),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.rosePink,
              side: BorderSide(color: AppTheme.rosePink.withValues(alpha: 0.5), width: 2),
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.ecoGreen,
              child: Text('YG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
            ),
            SizedBox(width: 4.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Name', style: Theme.of(context).textTheme.titleLarge),
                Text('Eco-Warrior', style: TextStyle(color: AppTheme.hareGray)),
              ],
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    bool? value,
    ValueChanged<bool>? onChanged,
    String? trailingText,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 1.h),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppTheme.wolfGray),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: value != null
            ? Switch(
                value: value,
                onChanged: onChanged,
                activeTrackColor: AppTheme.ecoGreen,
              )
            : trailingText != null
                ? Text(trailingText, style: TextStyle(color: AppTheme.hareGray, fontWeight: FontWeight.bold, fontSize: 10.sp))
                : Icon(Icons.arrow_forward_ios, size: 12.sp, color: AppTheme.hareGray),
      ),
    );
  }
}
