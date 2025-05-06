import 'package:flutter/material.dart';
import 'package:task01/presentation/theme/app_colors.dart';

/// Centralized theme configuration for the application
class AppTheme {
  /// Light theme configuration
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'SFProText',
    brightness: Brightness.light,
    unselectedWidgetColor: AppColors.black,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.info),
      titleTextStyle: TextStyle(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  /// Dark theme configuration
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'SFProText',
    brightness: Brightness.dark,
    unselectedWidgetColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.info),
      titleTextStyle: TextStyle(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
      elevation: 0,
    ),
  );
}
