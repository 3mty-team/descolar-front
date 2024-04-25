import 'package:descolar_front/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      fontFamily: 'Helvetica',
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: AppColors.black,
        ),
      ),
    );
  }
}
