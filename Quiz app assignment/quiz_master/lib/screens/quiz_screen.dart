import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_master/router/app_router.dart';

import '../models/question.dart';
import '../models/quiz_result.dart';
import '../theme/app_theme.dart';
import '../widgets/answer_buttons.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String title;

  const QuizScreen({super.key, required this.questions, required this.title});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;
  final List<AnswerRecord> _records = [];

  Question get _currentQuestion => widget.questions[_currentIndex];

  int get _maxScore =>
      widget.questions.fold<int>(0, (sum, q) => sum + q.difficulty.points);

  void _selectAnswer(int index) {
    if (_answered) return;

    final isCorrect = index == _currentQuestion.correctIndex;
    final points = isCorrect ? _currentQuestion.difficulty.points : 0;

    setState(() {
      _selectedIndex = index;
      _answered = true;
      _score += points;
    });

    _records.add(
      AnswerRecord(
        questionId: _currentQuestion.id,
        selectedIndex: index,
        correctIndex: _currentQuestion.correctIndex,
        isCorrect: isCorrect,
        pointsEarned: points,
      ),
    );
  }

  void _skipQuestion() {
    if (_answered) return;

    _records.add(
      AnswerRecord(
        questionId: _currentQuestion.id,
        selectedIndex: null,
        correctIndex: _currentQuestion.correctIndex,
        isCorrect: false,
        pointsEarned: 0,
      ),
    );

    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedIndex = null;
        _answered = false;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz() {
    final result = QuizResult(
      totalQuestions: widget.questions.length,
      correctAnswers: _records.where((r) => r.isCorrect).length,
      totalScore: _score,
      maxScore: _maxScore,
      answers: _records,
    );

    context.go(
      AppRouter.result,
      extra: {'result': result, 'questions': widget.questions},
    );
  }

  AnswerState _stateForOption(int index) {
    if (!_answered) return AnswerState.neutral;
    if (index == _currentQuestion.correctIndex) {
      return _selectedIndex == index
          ? AnswerState.correct
          : AnswerState.revealed;
    }
    if (index == _selectedIndex) return AnswerState.wrong;
    return AnswerState.neutral;
  }

  static const List<String> _letters = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == widget.questions.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _QuizAppBar(title: widget.title),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _ProgressPanel(
                      currentIndex: _currentIndex,
                      totalQuestions: widget.questions.length,
                      score: _score,
                      maxScore: _maxScore,
                    ),
                    const SizedBox(height: 16),
                    _buildQuestionCard(isLast),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(bool isLast) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EDF8)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(label: _currentQuestion.category),
              _InfoChip(label: _currentQuestion.difficulty.label),
              _InfoChip(label: '+${_currentQuestion.difficulty.points} pts'),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Q${_currentIndex + 1}. ${_currentQuestion.text}',
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0D1B2A),
              fontFamily: 'Nunito',
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(
            _currentQuestion.options.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AnswerButton(
                label: _currentQuestion.options[i],
                optionLetter: _letters[i],
                state: _stateForOption(i),
                onTap: () => _selectAnswer(i),
              ),
            ),
          ),
          if (_answered && _currentQuestion.explanation != null) ...[
            const SizedBox(height: 4),
            _ExplanationBox(text: _currentQuestion.explanation!),
            const SizedBox(height: 16),
          ],
          if (_answered)
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLast ? 'See Results' : 'Next Question'),
                  const SizedBox(width: 8),
                  Icon(
                    isLast
                        ? Icons.emoji_events_rounded
                        : Icons.arrow_forward_rounded,
                    size: 18,
                  ),
                ],
              ),
            )
          else
            OutlinedButton.icon(
              onPressed: _skipQuestion,
              icon: const Icon(Icons.skip_next_rounded),
              label: Text(isLast ? 'Skip and Finish' : 'Skip Question'),
            ),
        ],
      ),
    );
  }
}

class _QuizAppBar extends StatelessWidget {
  final String title;

  const _QuizAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.go(AppRouter.home),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _ProgressPanel extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;
  final int score;
  final int maxScore;

  const _ProgressPanel({
    required this.currentIndex,
    required this.totalQuestions,
    required this.score,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentIndex + 1) / totalQuestions;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EDF8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${currentIndex + 1} of $totalQuestions',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  fontFamily: 'Nunito',
                ),
              ),
              Text(
                'Score $score/$maxScore',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0D1B2A),
                  fontFamily: 'Nunito',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE8EDF8),
              color: AppTheme.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.primaryBlue,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }
}

class _ExplanationBox extends StatelessWidget {
  final String text;

  const _ExplanationBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBBD0FF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_outline_rounded,
            size: 18,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1A2340),
                fontFamily: 'Nunito',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
