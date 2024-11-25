import 'package:flutter/material.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/model/quiz.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/model/submission.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final Quiz quiz;
  final Submission submission;
  final VoidCallback onRestart;

  const ResultScreen({
    required this.quiz,
    required this.submission,
    required this.onRestart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int correctAnswers = submission.getScore();

    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You answered $correctAnswers on ${quiz.questions.length} !',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ...quiz.questions.asMap().entries.map((entry) {
            final int index = entry.key;
            final Question question = entry.value;
            final Answer? userAnswer = submission.getAnswerFor(question);

            return ResultItem(
              questionNumber: index + 1,
              question: question.title,
              possibleAnswers: question.possibleAnswers,
              userAnswer: userAnswer?.inputAnswer,
              correctAnswer: question.goodAnswer,
              isCorrect: userAnswer?.isCorrect() ?? false,
            );
          }),
          const SizedBox(height: 20),
          AppButton(
            'Restart Quiz',
            onTap: onRestart,
            icon: Icons.restart_alt,
          ),
        ],
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final int questionNumber;
  final String question;
  final List<String> possibleAnswers;
  final String? userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const ResultItem({
    required this.questionNumber,
    required this.question,
    required this.possibleAnswers,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: isCorrect ? Colors.green : Colors.red,
                  radius: 20,
                  child: Text(
                    '$questionNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...possibleAnswers.map((answer) {
            bool isUserAnswer = answer == userAnswer;
            bool isCorrectAnswer = answer == correctAnswer;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 60),
              child: Row(
                children: [
                  if (isCorrectAnswer)
                    const Icon(Icons.check, color: Colors.green)
                  else if (isUserAnswer)
                    const Icon(Icons.close, color: Colors.red)
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 8),
                  Text(
                    answer,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
