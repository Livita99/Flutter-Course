import 'package:flutter/material.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/model/quiz.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/widgets/question_button.dart';

class QuestionScreen extends StatelessWidget {
  final Question question;
  final void Function(String) onTap;

  const QuestionScreen({
    required this.question,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question.title,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          ...question.possibleAnswers.map(
            (answer) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: QuestionButton(
                answer,
                onTap: () => onTap(answer),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
