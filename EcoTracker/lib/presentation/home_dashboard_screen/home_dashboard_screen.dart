import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sizer/sizer.dart';
import '../../core/data/mock_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/visual_effects.dart';
import '../../core/localization/app_localization.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInSlide(
          delay: Duration(milliseconds: 100),
          offset: -20,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department, color: AppTheme.fireOrange),
              SizedBox(width: 8),
              Text('12 Days'),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: FadeInSlide(
              delay: Duration(milliseconds: 200),
              offset: -20,
              child: Icon(Icons.notifications_outlined, color: AppTheme.wolfGray),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInSlide(
              delay: Duration(milliseconds: 100),
              child: Text(AppLocalization().translate('impact'), style: Theme.of(context).textTheme.headlineMedium),
            ),
            SizedBox(height: 2.h),
            FadeInSlide(
              delay: Duration(milliseconds: 200),
              child: _buildChartCard(context),
            ),
            SizedBox(height: 3.h),
            FadeInSlide(
              delay: Duration(milliseconds: 300),
              child: Text(AppLocalization().translate('recent_actions'), style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: 1.5.h),
            ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: MockDatabase().actionLogs,
              builder: (context, logs, _) {
                if (logs.isEmpty) return Text("No logged actions yet.");
                return Column(
                  children: List.generate(logs.length, (index) {
                    final log = logs[index];
                    return _buildActionItem(
                      context,
                      icon: IconData(log['iconCode'], fontFamily: 'MaterialIcons'),
                      color: Color(log['colorValue']),
                      title: log['title'],
                      subtitle: log['subtitle'],
                      time: log['time'],
                      delay: 400 + (index * 100),
                    );
                  }),
                );
              },
            ),
            // Padding for FAB
            SizedBox(height: 8.h),
          ],
        ),
      ),
      floatingActionButton: BouncyWrapper(
        onTap: () => _showLogActionDialog(context),
        child: FloatingActionButton.extended(
          onPressed: () => _showLogActionDialog(context),
          icon: Icon(Icons.add),
          label: Text(AppLocalization().translate('log_action')),
        ),
      ),
    );
  }

  void _showLogActionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _LogActionSheet(),
    );
  }

  Widget _buildChartCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('CO2 Footprint', style: Theme.of(context).textTheme.titleMedium),
                DropdownButton<String>(
                  value: 'Week',
                  items: ['Week', 'Month', 'Year']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) {},
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            AspectRatio(
              aspectRatio: 1.7,
              child: ValueListenableBuilder<List<double>>(
                valueListenable: MockDatabase().weeklyEmissions,
                builder: (context, data, _) {
                   return BarChart(
                    BarChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const titles = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                              if (value.toInt() < titles.length) {
                                 return Padding(
                                   padding: const EdgeInsets.only(top: 8.0),
                                   child: Text(titles[value.toInt()], style: TextStyle(color: AppTheme.hareGray, fontWeight: FontWeight.bold)),
                                 );
                              }
                              return SizedBox();
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(data.length, (index) => _makeGroupData(index, data[index])),
                    ),
                    swapAnimationDuration: Duration(milliseconds: 1000), // Fluid chart
                    swapAnimationCurve: Curves.linearToEaseOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppTheme.ecoGreen,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20, // Increased max
            color: AppTheme.polarSnow,
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
    required int delay,
  }) {
    return FadeInSlide(
      delay: Duration(milliseconds: delay),
      child: Card(
        margin: EdgeInsets.only(bottom: 1.5.h),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: Text(time, style: TextStyle(color: AppTheme.hareGray, fontSize: 10.sp)),
        ),
      ),
    );
  }
}

class _LogActionSheet extends StatefulWidget {
  @override
  _LogActionSheetState createState() => _LogActionSheetState();
}

class _LogActionSheetState extends State<_LogActionSheet> {
  String _selectedCategory = 'Transport';
  double _amount = 1.0;
  final TextEditingController _titleController = TextEditingController();

  final Map<String, String> _units = {
    'Transport': 'km cycled/walked',
    'Food': 'meals',
    'Energy': 'hours saved',
    'Waste': 'kg recycled',
  };

  @override
  Widget build(BuildContext context) {
    // Keyboard awareness
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 10.w,
                  height: 4,
                  decoration: BoxDecoration(color: AppTheme.hareGray, borderRadius: BorderRadius.circular(2)),
                ),
              ),
              SizedBox(height: 2.h),
              Text('Log New Activity', style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 2.h),
              
              // Title Input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Activity Name (e.g. Cycled to work)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 2.h),

              // Category Selector
              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                items: ['Transport', 'Food', 'Energy', 'Waste']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 2.h),

              // Amount Slider
              Text('Amount: ${_amount.toStringAsFixed(1)} ${_units[_selectedCategory]}', 
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _amount,
                min: 0.5,
                max: 20.0,
                divisions: 39,
                label: _amount.toString(),
                activeColor: AppTheme.ecoGreen,
                onChanged: (v) => setState(() => _amount = v),
              ),
              
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                      MockDatabase().logActivity(
                        _titleController.text,
                        _selectedCategory,
                        _amount,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Analyze & Log'),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
