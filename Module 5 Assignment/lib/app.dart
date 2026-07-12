import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/grade_tracker_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

class GradeTrackerApp extends StatelessWidget {
  const GradeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select<GradeTrackerProvider, bool>(
      (provider) => provider.isDarkMode,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Grade Tracker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
