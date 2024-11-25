import 'package:flutter_workspace/W7-S2-Flutter-Quiz/model/quiz.dart';

class Answer {
  final Question question;
  String inputAnswer;
  bool isCorrect() => question.goodAnswer == inputAnswer;

  Answer({required this.question, required this.inputAnswer});
}

class Submission {
  final List<Answer> possibleAnswers = [];

  int getScore() {
    int score = 0;
    for (Answer inputAnswer in possibleAnswers) {
      if (inputAnswer.isCorrect()) {
        score++;
      }
    }
    return score;
  }

  Answer? getAnswerFor(Question question) {
    for (Answer goodAnswer in possibleAnswers) {
      if (question == goodAnswer.question) {
        return goodAnswer;
      }
    }
    return null;
  }

  void addAnswer(Question question, String answer) {
    final existingAnswer = getAnswerFor(question);
    if (existingAnswer != null) {
      existingAnswer.inputAnswer = answer;
    } else {
      possibleAnswers.add(Answer(question: question, inputAnswer: answer));
    }
  }

  void removeAnswers() {
    possibleAnswers.clear();
  }
}
