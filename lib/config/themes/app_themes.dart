import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      fontFamily: 'Helvetica',
      scaffoldBackgroundColor: AppColors.white,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.black)),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.black,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Helvetica',
      scaffoldBackgroundColor: AppColors.black,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
        error: AppColors.errorDark,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
