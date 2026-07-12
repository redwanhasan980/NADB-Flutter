import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ColorScheme _scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF5B4DB7),
    brightness: Brightness.light,
  );

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: _scheme,
    scaffoldBackgroundColor: _scheme.surface,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: false,
      backgroundColor: _scheme.surface,
      foregroundColor: _scheme.onSurface,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _scheme.surfaceContainerLow,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _scheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: _scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: _scheme.primary, width: 2),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
