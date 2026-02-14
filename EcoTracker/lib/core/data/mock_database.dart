import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockDatabase {
  static final MockDatabase _instance = MockDatabase._internal();
  factory MockDatabase() => _instance;
  MockDatabase._internal();

  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
  ValueNotifier<bool> isDarkMode = ValueNotifier(false);
  ValueNotifier<List<Map<String, dynamic>>> actionLogs = ValueNotifier([]);
  ValueNotifier<List<double>> weeklyEmissions = ValueNotifier([5, 6.5, 5, 7.5, 9, 11.5, 6.5]);

  // Keys
  static const String _keyAuth = 'is_logged_in';
  static const String _keyTheme = 'is_dark_mode';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool(_keyAuth) ?? false;
    isDarkMode.value = prefs.getBool(_keyTheme) ?? false;
    
    // Initialize dummy data if empty
    if (actionLogs.value.isEmpty) {
      actionLogs.value = [
         {'title': 'Cycled to Work', 'subtitle': 'Saved 2.5kg CO2', 'time': '2 hours ago', 'iconCode': 57691, 'colorValue': 0xFF1CB0F6},
         {'title': 'Recycled Plastic', 'subtitle': 'Saved 0.5kg CO2', 'time': '5 hours ago', 'iconCode': 59528, 'colorValue': 0xFF58CC02},
         {'title': 'Plant-Based Meal', 'subtitle': 'Saved 1.2kg CO2', 'time': 'Yesterday', 'iconCode': 61274, 'colorValue': 0xFFFF9600},
      ];
    }
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAuth, true);
    isLoggedIn.value = true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyAuth, false);
    isLoggedIn.value = false;
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !isDarkMode.value;
    await prefs.setBool(_keyTheme, newValue);
    isDarkMode.value = newValue;
  }

  // Analysis Engine
  Map<String, dynamic> analyzeActivity(String category, double amount) {
    double co2Saved = 0.0;
    String insight = '';
    IconData icon = Icons.help_outline;
    Color color = Colors.grey;

    switch (category) {
      case 'Transport':
        // Avg car emits 0.2kg CO2 per km. Public transport/Cycling saves almost all of this.
        co2Saved = amount * 0.15; // Conservative estimate of savings per km
        icon = Icons.directions_bike;
        color = Color(0xFF1CB0F6); // Sky Blue
        if (amount > 10) insight = "That's like taking 2 cars off the road!";
        else insight = "Great start! Every km counts.";
        break;
      case 'Food':
        // Plant-based meal saves ~1.5kg CO2 vs meat meal
        co2Saved = amount * 1.5; // amount = number of meals
        icon = Icons.restaurant_menu;
        color = Color(0xFF58CC02); // Eco Green
        if (amount >= 3) insight = "You saved enough water for a week!";
        else insight = "Delicious and planet-friendly!";
        break;
      case 'Energy':
        // 1 hour of LED vs Incandescent saves ~0.05kg
        co2Saved = amount * 0.05; // amount = hours
        icon = Icons.lightbulb_outline;
        color = Color(0xFFFFC800); // Rubber Duck Yellow
        insight = "Bright idea! Energy efficiency is key.";
        break;
      case 'Waste':
        // Recycling 1kg of plastic saves ~1.5kg CO2
        co2Saved = amount * 1.2; // amount = kg recycled
        icon = Icons.recycling;
        color = Color(0xFFFF9600); // Fire Orange
        insight = "Recycling hero! Keeping oceans clean.";
        break;
    }

    return {
      'co2': double.parse(co2Saved.toStringAsFixed(2)),
      'insight': insight,
      'icon': icon,
      'color': color,
    };
  }

  void logActivity(String title, String category, double amount) {
    final analysis = analyzeActivity(category, amount);
    
    final newLog = {
      'title': title,
      'subtitle': 'Saved ${analysis['co2']}kg • ${analysis['insight']}',
      'time': 'Just now',
      'iconCode': (analysis['icon'] as IconData).codePoint,
      'colorValue': (analysis['color'] as Color).toARGB32(),
    };
    
    actionLogs.value = [newLog, ...actionLogs.value];
    
    // Update graph
    final currentWeek = List<double>.from(weeklyEmissions.value);
    if (currentWeek.isNotEmpty) {
      currentWeek[currentWeek.length - 1] = (currentWeek.last - (analysis['co2'] as double)).clamp(0.0, 20.0);
      weeklyEmissions.value = currentWeek;
    }
  }

  // Deprecated: simplistic addLog
  void addLog(String title, double co2Saved, IconData icon, Color color) {
    logActivity(title, 'Waste', co2Saved); // Fallback
  }
}
