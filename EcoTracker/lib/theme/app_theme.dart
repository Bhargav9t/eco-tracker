import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

/// A class that contains all theme configurations for the application.
/// Implements a Duolingo-inspired "Gamified Eco" design.
class AppTheme {
  AppTheme._();

  // Duo-Eco Palette
  static const Color ecoGreen = Color(0xFF58CC02); // Main Action
  static const Color ecoGreenShadow = Color(0xFF46A302); // 3D Shadow
  static const Color skyBlue = Color(0xFF1CB0F6); // Secondary Action
  static const Color skyBlueShadow = Color(0xFF1899D6);
  static const Color fireOrange = Color(0xFFFF9600); // Streak/Warning
  static const Color fireOrangeShadow = Color(0xFFE48400);
  static const Color rosePink = Color(0xFFFF4B4B); // Error/Close
  static const Color rosePinkShadow = Color(0xFFEA2B2B);
  static const Color rubberDuckYellow = Color(0xFFFFC800); // Gold/Stars
  static const Color rubberDuckYellowShadow = Color(0xFFE5B400);

  // Neutrals
  static const Color featherWhite = Color(0xFFFFFFFF);
  static const Color hareGray = Color(0xFFAFAFAF); // Disabled/Placeholder
  static const Color wolfGray = Color(0xFF4B4B4B); // Text
  static const Color polarSnow = Color(0xFFF7F7F7); // Background
  static const Color eelBlack = Color(0xFF3C3C3C); // Dark Mode Background

  /// Light theme - Gamified, Bright, Rounded
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: polarSnow,
    colorScheme: ColorScheme.light(
      primary: ecoGreen,
      onPrimary: featherWhite,
      secondary: skyBlue,
      onSecondary: featherWhite,
      error: rosePink,
      onError: featherWhite,
      surface: featherWhite,
      onSurface: wolfGray,
      tertiary: fireOrange,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: featherWhite,
      foregroundColor: wolfGray,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18.sp.clamp(18.0, 24.0),
        fontWeight: FontWeight.w800,
        color: wolfGray,
      ),
      iconTheme: IconThemeData(color: wolfGray),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: featherWhite,
      selectedItemColor: ecoGreen,
      unselectedItemColor: hareGray,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      selectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 12.sp.clamp(12.0, 16.0)),
      unselectedLabelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 12.sp.clamp(12.0, 16.0)),
    ),
    cardTheme: CardThemeData(
      color: featherWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFFE5E5E5), width: 2),
      ),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: featherWhite,
        backgroundColor: ecoGreen,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 14.sp.clamp(14.0, 18.0),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ).copyWith(
        // Simulating 3D button effect with shadow logic would be custom, 
        // but standard elevation is kept simple here.
        shadowColor: WidgetStateProperty.all(ecoGreenShadow),
        elevation: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.pressed) ? 0.0 : 4.0;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: wolfGray,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: BorderSide(color: Color(0xFFE5E5E5), width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: GoogleFonts.nunito(
          fontSize: 14.sp.clamp(14.0, 18.0),
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: skyBlue,
      foregroundColor: featherWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    textTheme: _buildTextTheme(isLight: true),
  );

  /// Dark theme - Simplified reverse
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: eelBlack,
    colorScheme: ColorScheme.dark(
      primary: ecoGreen,
      onPrimary: featherWhite,
      secondary: skyBlue,
      onSecondary: featherWhite,
      error: rosePink,
      surface: Color(0xFF2C2C2C),
      onSurface: featherWhite,
      tertiary: fireOrange,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: eelBlack,
      foregroundColor: featherWhite,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18.sp.clamp(18.0, 24.0),
        fontWeight: FontWeight.w800,
        color: featherWhite,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF2C2C2C),
      selectedItemColor: ecoGreen,
      unselectedItemColor: Color(0xFF777777),
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF2C2C2C),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFF4B4B4B), width: 2),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
  );

  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textColor = isLight ? wolfGray : featherWhite;
    return TextTheme(
      displayLarge: GoogleFonts.nunito(
        fontSize: 24.sp.clamp(24.0, 36.0),
        fontWeight: FontWeight.w900,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 20.sp.clamp(20.0, 30.0),
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 16.sp.clamp(16.0, 24.0),
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 14.sp.clamp(14.0, 20.0),
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 14.sp.clamp(14.0, 18.0),
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 12.sp.clamp(12.0, 16.0),
        fontWeight: FontWeight.w600,
        color: textColor.withValues(alpha: 0.8),
      ),
    );
  }
}
