import 'dart:io';

class Participant {
  final String firstName;
  final String lastName;

  Participant(this.firstName, this.lastName);
}

abstract class Question {
  final String questionText;
  final List<String> options;

  Question(this.questionText, this.options);

  bool checkAnswer(List<int> selectedIndices);
}

class SingleChoiceQuestion extends Question {
  final int correctAnswerIndex;

  SingleChoiceQuestion(
      String questionText, List<String> options, this.correctAnswerIndex)
      : super(questionText, options);

  @override
  bool checkAnswer(List<int> selectedIndices) {
    return selectedIndices.length == 1 &&
        selectedIndices.first == correctAnswerIndex;
  }
}

class MultipleChoiceQuestion extends Question {
  final List<int> correctAnswerIndices;

  MultipleChoiceQuestion(
      String questionText, List<String> options, this.correctAnswerIndices)
      : super(questionText, options);

  @override
  bool checkAnswer(List<int> selectedIndices) {
    var selectedSet = Set.from(selectedIndices);
    var correctSet = Set.from(correctAnswerIndices);

    bool isCorrect = selectedSet.length == correctSet.length &&
        selectedSet.containsAll(correctSet);
    return isCorrect;
  }
}

class Result {
  final Participant participant;
  int score = 0;

  Result(this.participant);

  void incrementScore() {
    score++;
  }

  void displayResult(int totalQuestions) {
    print(
        '${participant.firstName} ${participant.lastName}, your score is $score/$totalQuestions\n');
  }
}

class Quiz {
  final String title;
  final List<Question> questions = [];

  Quiz(this.title);

  void addQuestion(Question question) {
    questions.add(question);
  }

  Result takeQuiz(Participant participant) {
    final result = Result(participant);

    print('\nStarting Quiz: $title\n');
    for (var question in questions) {
      _displayQuestion(question);

      List<int> selectedIndices = _getAnswerInput(question.options.length);
      if (question.checkAnswer(selectedIndices)) {
        result.incrementScore();
        print("Correct!\n");
      } else {
        print("Incorrect.\n");
      }
    }
    return result;
  }

  void _displayQuestion(Question question) {
    print(question.questionText);
    for (int i = 0; i < question.options.length; i++) {
      print('${i + 1}. ${question.options[i]}');
    }
    print("Enter your answer(s): (For multiple answers, separate with commas)");
  }

  List<int> _getAnswerInput(int optionsCount) {
    String? answer = stdin.readLineSync();
    if (answer == null || answer.isEmpty) return [];

    List<int> parsedAnswers = answer
        .split(',')
        .map((a) => int.tryParse(a.trim()) ?? -1)
        .where((index) => index > 0 && index <= optionsCount)
        .map((index) => index - 1)
        .toList();
    return parsedAnswers;
  }
}

void main() {
  final quiz = Quiz('IT Quiz');
  final results = <Result>[];

  quiz.addQuestion(SingleChoiceQuestion(
    'Which of the following is a programming language?',
    ['Python', 'HTTP', 'FTP', 'HTML'],
    0,
  ));

  quiz.addQuestion(MultipleChoiceQuestion(
    'Which of the following are types of cybersecurity threats? (Select all that apply)',
    ['Virus', 'Worm', 'Firewall', 'Trojan'],
    [0, 1, 3],
  ));

  while (true) {
    print('\n----- Main Menu -----');
    print('1. Take a Quiz');
    print('2. View results');
    print('3. Exit');
    print('Enter your choice:');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        _startQuiz(quiz, results);
        break;
      case '2':
        _displayResults(results, quiz.questions.length);
        break;
      case '3':
        print('Exit Successfully...');
        return;
      default:
        print('Invalid choice. Please try again.');
    }
  }
}

void _startQuiz(Quiz quiz, List<Result> results) {
  print("Enter your first name:");
  String firstName = stdin.readLineSync() ?? '';

  print("Enter your last name:");
  String lastName = stdin.readLineSync() ?? '';

  final participant = Participant(firstName, lastName);
  final result = quiz.takeQuiz(participant);

  results.add(result);
  result.displayResult(quiz.questions.length);
}

void _displayResults(List<Result> results, int quizLength) {
  if (results.isEmpty) {
    print("No results to display.\n");
    return;
  }

  print("\n--- Quiz Results ---");
  for (var result in results) {
    result.displayResult(quizLength);
  }
}
