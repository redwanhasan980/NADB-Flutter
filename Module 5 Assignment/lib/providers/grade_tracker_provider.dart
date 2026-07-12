import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/subject.dart';

class GradeTrackerProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  UnmodifiableListView<Subject> get subjects => UnmodifiableListView(_subjects);
  int get selectedIndex => _selectedIndex;
  bool get isDarkMode => _isDarkMode;
  int get totalSubjects => _subjects.length;

  // Uses where() as required and exposes a useful summary statistic.
  int get passingSubjects =>
      _subjects.where((subject) => subject.mark >= 50).length;

  double get averageMark {
    if (_subjects.isEmpty) return 0;
    final total = _subjects
        .map((subject) => subject.mark)
        .fold<double>(0, (sum, mark) => sum + mark);
    return total / _subjects.length;
  }

  String get overallGrade =>
      _subjects.isEmpty ? '—' : Subject.gradeFor(averageMark);

  void addSubject(String name, double mark) {
    _subjects.add(Subject(name: name.trim(), mark: mark));
    notifyListeners();
  }

  void removeSubject(Subject subject) {
    _subjects.remove(subject);
    notifyListeners();
  }

  void selectScreen(int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
  }

  void showSubjectList() => selectScreen(1);

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
