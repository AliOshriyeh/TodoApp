import 'package:flutter/material.dart';
import 'package:task01/presentation/theme/app_colors.dart';

final ThemeData appThemeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'SFProText',
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.black),
    titleTextStyle: TextStyle(color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  // primaryColor: AppColors.primary,
  // indicatorColor: AppColors.secondary,
  // canvasColor: AppColors.surface,
);
