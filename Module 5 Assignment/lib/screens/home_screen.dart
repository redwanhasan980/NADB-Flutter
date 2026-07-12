import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/grade_tracker_provider.dart';
import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _titles = ['Add Subject', 'Subject List', 'Summary'];
  static const _screens = [
    AddSubjectScreen(),
    SubjectListScreen(),
    SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GradeTrackerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[provider.selectedIndex]),
        actions: [
          IconButton(
            onPressed: provider.toggleTheme,
            tooltip: provider.isDarkMode
                ? 'Switch to light theme'
                : 'Switch to dark theme',
            icon: Icon(
              provider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: provider.selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedIndex,
        onTap: provider.selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Subjects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Summary',
          ),
        ],
      ),
    );
  }
}
