// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/constants/app_colors.dart';
import 'package:shartflix/core/theme/theme_data/app_style.dart';

class LightThemeData {
  static LightThemeData? _instance;

  static LightThemeData get instance => _instance ??= LightThemeData._init();

  LightThemeData._init();

  ThemeData data = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: AppStyles.hintText,
    ),
    textTheme: TextTheme(
      bodyMedium: AppStyles.body,
      titleLarge: AppStyles.title,
      labelLarge: AppStyles.button,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        textStyle: AppStyles.button,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),
  );
}
