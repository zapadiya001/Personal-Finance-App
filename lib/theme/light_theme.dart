import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4CAF50); // Emerald Green
  static const Color secondary = Color(0xFF03A9F4); // Light Blue
  static const Color background = Color(0xFFF9F9F9); // Almost White
  static const Color textPrimary = Color(0xFF212121); // Dark Grey
  static const Color income = Color(0xFF2E7D32); // Deep Green
  static const Color expense = Color(0xFFD32F2F); // Red
  static const Color neutral = Color(0xFF9E9E9E); // Grey
}


ColorScheme appColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: Colors.white,
  secondary: AppColors.secondary,
  onSecondary: Colors.white,
  error: AppColors.expense,
  onError: Colors.white,
  background: AppColors.background,
  onBackground: AppColors.textPrimary,
  surface: Colors.white,
  onSurface: AppColors.textPrimary,
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: appColorScheme,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.textPrimary,
    elevation: 0,
  ),
  iconTheme: IconThemeData(color: AppColors.neutral),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.secondary,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme().copyWith(
    titleLarge: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: AppColors.textPrimary),
    bodyMedium: TextStyle(color: AppColors.textPrimary),
    labelSmall: TextStyle(color: AppColors.neutral),
  ),
);