import 'package:flutter/material.dart';
import 'package:quiz_master/widgets/home_header.dart';

import '../data/questions_data.dart';
import '../models/question.dart';
import '../widgets/home_start_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _allCategories = 'All categories';
  static const _allDifficulties = 'All difficulties';

  String _category = _allCategories;
  String _difficulty = _allDifficulties;

  Difficulty? get _selectedDifficulty {
    switch (_difficulty) {
      case 'Easy':
        return Difficulty.easy;
      case 'Medium':
        return Difficulty.medium;
      case 'Hard':
        return Difficulty.hard;
      default:
        return null;
    }
  }

  List<Question> get _questions => QuestionsData.filter(
    category: _category == _allCategories ? null : _category,
    difficulty: _selectedDifficulty,
  );

  String get _quizTitle {
    final parts = <String>[
      if (_category != _allCategories) _category,
      if (_difficulty != _allDifficulties) _difficulty,
    ];

    return parts.isEmpty ? 'Flutter Quiz' : '${parts.join(' ')} Quiz';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: Column(
          children: [
            HomeHeader(onProfileTap: () {}),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                child: Column(
                  children: [
                    _QuizFilterPanel(
                      category: _category,
                      difficulty: _difficulty,
                      categories: QuestionsData.categories,
                      onCategoryChanged: (value) {
                        setState(() => _category = value ?? _allCategories);
                      },
                      onDifficultyChanged: (value) {
                        setState(() => _difficulty = value ?? _allDifficulties);
                      },
                    ),
                    const SizedBox(height: 20),
                    HomeStartCard(
                      screenWidth: screenWidth,
                      title: _quizTitle,
                      questions: _questions,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizFilterPanel extends StatelessWidget {
  final String category;
  final String difficulty;
  final List<String> categories;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<String?> onDifficultyChanged;

  const _QuizFilterPanel({
    required this.category,
    required this.difficulty,
    required this.categories,
    required this.onCategoryChanged,
    required this.onDifficultyChanged,
  });

  static const _difficultyOptions = [
    _HomeScreenState._allDifficulties,
    'Easy',
    'Medium',
    'Hard',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EDF8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customize quiz',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: category,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: [
              const DropdownMenuItem(
                value: _HomeScreenState._allCategories,
                child: Text(_HomeScreenState._allCategories),
              ),
              ...categories.map(
                (value) => DropdownMenuItem(value: value, child: Text(value)),
              ),
            ],
            onChanged: onCategoryChanged,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: difficulty,
            decoration: const InputDecoration(
              labelText: 'Difficulty',
              border: OutlineInputBorder(),
            ),
            items: _difficultyOptions
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: onDifficultyChanged,
          ),
        ],
      ),
    );
  }
}
