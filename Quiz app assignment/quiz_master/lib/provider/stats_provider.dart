import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/quiz_result.dart';

class StatsProvider extends ChangeNotifier {
  static const _attemptsKey = 'attempts';
  static const _bestScoreKey = 'best_score';
  static const _bestMaxScoreKey = 'best_max_score';
  static const _bestPercentageKey = 'best_percentage';

  int _attempts = 0;
  int _bestScore = 0;
  int _bestMaxScore = 0;
  double _bestPercentage = 0;
  bool _isLoaded = false;

  int get attempts => _attempts;
  int get bestScore => _bestScore;
  int get bestMaxScore => _bestMaxScore;
  double get bestPercentage => _bestPercentage;
  bool get isLoaded => _isLoaded;
  bool get hasBestScore => _bestMaxScore > 0;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _attempts = prefs.getInt(_attemptsKey) ?? 0;
    _bestScore = prefs.getInt(_bestScoreKey) ?? 0;
    _bestMaxScore = prefs.getInt(_bestMaxScoreKey) ?? 0;
    _bestPercentage = prefs.getDouble(_bestPercentageKey) ?? 0;
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> recordResult(QuizResult result) async {
    if (!_isLoaded) {
      await load();
    }

    _attempts++;

    final isNewBest =
        result.percentage > _bestPercentage ||
        (result.percentage == _bestPercentage &&
            result.totalScore > _bestScore);

    if (isNewBest) {
      _bestScore = result.totalScore;
      _bestMaxScore = result.maxScore;
      _bestPercentage = result.percentage;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_attemptsKey, _attempts);
    await prefs.setInt(_bestScoreKey, _bestScore);
    await prefs.setInt(_bestMaxScoreKey, _bestMaxScore);
    await prefs.setDouble(_bestPercentageKey, _bestPercentage);

    notifyListeners();
  }
}
