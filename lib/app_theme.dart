import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color navy = Color(0xFF0B1220);
  static const Color panel = Color(0xFF111C30);
  static const Color panelLight = Color(0xFF17243B);
  static const Color mint = Color(0xFF43E6A0);
  static const Color blue = Color(0xFF4C8DFF);
  static const Color text = Color(0xFFF4F7FB);
  static const Color muted = Color(0xFF9AA9BF);
}

ThemeData buildTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.navy,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.mint,
      secondary: AppColors.blue,
      surface: AppColors.panel,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: AppColors.text,
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.2,
      ),
      headlineSmall: TextStyle(
        color: AppColors.text,
        fontSize: 21,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.text,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(color: AppColors.muted, height: 1.45),
    ),
    cardTheme: const CardThemeData(
      color: AppColors.panel,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        side: BorderSide(color: Color(0xFF26344D)),
      ),
    ),
  );
}
