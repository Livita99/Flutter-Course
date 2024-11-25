import 'package:flutter/material.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;
  final String quizTitle;

  const WelcomeScreen(
      {required this.onStart, required this.quizTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/flutter_quiz/quiz-logo.png',
              width: 400, height: 400),
          const SizedBox(height: 15),
          Text(
            quizTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          AppButton(
            'Start Quiz',
            onTap: onStart,
            icon: Icons.trending_flat,
          ),
        ],
      ),
    );
  }
}
