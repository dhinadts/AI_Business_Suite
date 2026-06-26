import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF000A1E);
  static const navySoft = Color(0xFF002147);
  static const orange = Color(0xFFFD8B00);
  static const background = Color(0xFFF8F9FA);
  static const surface = Colors.white;
  static const darkBackground = Color(0xFF111318);
  static const darkSurface = Color(0xFF1B1E24);
  static const darkSurfaceHigh = Color(0xFF242832);
  static const darkOutline = Color(0xFF3A4050);
  static const teal = Color(0xFF007C78);
  static const amber = Color(0xFF9A5B00);
  static const red = Color(0xFFB3261E);
}

class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
      primary: AppColors.navy,
      secondary: AppColors.orange,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme.copyWith(
        primary: AppColors.navy,
        secondary: AppColors.orange,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFE8EBF0)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDDE3EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.navy, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.navy,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: Color(0xFFD6E3FF),
      onPrimary: AppColors.navy,
      secondary: AppColors.orange,
      onSecondary: Colors.black,
      surface: AppColors.darkSurface,
      onSurface: Color(0xFFF1F3F8),
      surfaceContainerHighest: AppColors.darkSurfaceHigh,
      outline: AppColors.darkOutline,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: 'Inter',
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.darkSurface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkOutline),
        ),
      ),
      dataTableTheme: const DataTableThemeData(
        headingTextStyle: TextStyle(
          color: Color(0xFFF1F3F8),
          fontWeight: FontWeight.w700,
        ),
        dataTextStyle: TextStyle(color: Color(0xFFE2E6EF)),
        dividerThickness: 0.7,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurfaceHigh,
        labelStyle: const TextStyle(color: Color(0xFFC5CBD8)),
        hintStyle: const TextStyle(color: Color(0xFF9EA6B8)),
        prefixIconColor: const Color(0xFFC5CBD8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.orange, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(44, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: Color(0xFFF1F3F8),
        elevation: 0,
        centerTitle: false,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.darkOutline),
    );
  }
}
