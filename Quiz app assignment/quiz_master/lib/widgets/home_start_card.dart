import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_master/router/app_router.dart';

import '../models/question.dart';
import '../models/quiz_settings.dart';
import '../theme/app_theme.dart';

class HomeStartCard extends StatelessWidget {
  final double screenWidth;
  final String title;
  final List<Question> questions;

  const HomeStartCard({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final hasQuestions = questions.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: hasQuestions ? const Color(0xFF4A90E2) : Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(70),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(50),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hasQuestions
                    ? '${questions.length} questions ready'
                    : 'No questions match these filters',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withAlpha(185),
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: screenWidth * 0.45,
                child: ElevatedButton(
                  onPressed: hasQuestions
                      ? () {
                          context.push(
                            AppRouter.quiz,
                            extra: QuizSettings(
                              title: title,
                              questions: questions,
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryBlue,
                    minimumSize: const Size(0, 46),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Start Quiz'),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
