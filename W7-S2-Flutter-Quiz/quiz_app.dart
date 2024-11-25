import 'package:flutter/material.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/model/submission.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/screens/question_screen.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/screens/result_screen.dart';
import 'package:flutter_workspace/W7-S2-Flutter-Quiz/screens/welcome_screen.dart';
import 'model/quiz.dart';

Color appColor = Colors.blue[500] as Color;

enum QuizState { notStarted, started, finished }

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState _quizState = QuizState.notStarted;
  int _currentQuestionIndex = 0;
  Submission _submission = Submission();

  Widget _getScreen() {
    switch (_quizState) {
      case QuizState.notStarted:
        return WelcomeScreen(
          onStart: _startQuiz,
          quizTitle: widget.quiz.title,
        );
      case QuizState.started:
        return QuestionScreen(
          question: widget.quiz.questions[_currentQuestionIndex],
          onTap: _answerQuestion,
        );
      case QuizState.finished:
        return ResultScreen(
          quiz: widget.quiz,
          submission: _submission,
          onRestart: _restartQuiz,
        );
    }
  }

  void _startQuiz() {
    setState(() {
      _quizState = QuizState.started;
      _currentQuestionIndex = 0;
      _submission = Submission();
    });
  }

  void _answerQuestion(String answer) {
    setState(() {
      _submission.addAnswer(
          widget.quiz.questions[_currentQuestionIndex], answer);
      if (_currentQuestionIndex == widget.quiz.questions.length - 1) {
        _quizState = QuizState.finished;
      } else {
        _currentQuestionIndex++;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _quizState = QuizState.notStarted;
      _currentQuestionIndex = 0;
      _submission = Submission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
