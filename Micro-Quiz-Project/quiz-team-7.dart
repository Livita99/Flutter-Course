import 'dart:io';

class Player {
  final String firstName;
  final String lastName;

  Player(this.firstName, this.lastName);
}

class Question {
  final String questionText;
  final List<String> options;
  final List<String> correctAnswers;

  const Question(this.questionText, this.options, this.correctAnswers);
}

class Quiz {
  final String title;
  final List<Question> questions;

  Quiz(this.title) : questions = [];

  void addQuestion(Question question) {
    questions.add(question);
  }

  void startQuiz(Player player) {
    print('\nWelcome ${player.firstName} ${player.lastName}!');
    print('Starting Quiz: $title');
    int score = 0;

    // Loop through each question in the quiz
    for (var question in questions) {
      // Display question and options
      print(question.questionText);
      for (int i = 0; i < question.options.length; i++) {
        print('${i + 1}. ${question.options[i]}');
      }

      String? answer = stdin.readLineSync();
      if (answer != null && answer.isNotEmpty) {
        try {
          // Split the input answer
          List<int> answerIndices =
              answer.split(',').map((a) => int.parse(a.trim()) - 1).toList();
          List<String> selectedAnswers = [];

          // Get selected answers
          for (int index in answerIndices) {
            if (index >= 0 && index < question.options.length) {
              selectedAnswers.add(question.options[index]);
            }
          }

          // Check for correct answers
          if (selectedAnswers.isEmpty) {
            print('No valid options selected. Please try again.\n');
          } else if (selectedAnswers
                  .toSet()
                  .containsAll(question.correctAnswers.toSet()) &&
              selectedAnswers.length == question.correctAnswers.length) {
            score++;
            print('Correct!\n');
          } else {
            print(
                'Wrong! The correct answers were: ${question.correctAnswers.join(', ')}\n');
          }
        } catch (e) {
          print(
              'Invalid input. Please enter a number corresponding to the options.\n');
        }
      } else {
        print('You must enter at least one answer.\n');
      }
    }
    print(
        'Quiz finished! ${player.firstName} ${player.lastName}, your score is $score/${questions.length}');
  }
}

void main() {
  print('Enter your first name:');
  String firstName = stdin.readLineSync() ?? '';

  print('Enter your last name:');
  String lastName = stdin.readLineSync() ?? '';

  final player = Player(firstName, lastName);
  final quiz = Quiz('General Knowledge');

  quiz.addQuestion(const Question(
    'Which of the following is a programming language?',
    ['Python', 'HTTP', 'FTP', 'HTML'],
    ['Python'],
  ));

  quiz.addQuestion(const Question(
    'Which of the following are types of cybersecurity threats? (Pick all that apply. e.g., "1,2,3")',
    ['Virus', 'Worm', 'Firewall', 'Trojan'],
    ['Virus', 'Worm', 'Trojan'],
  ));

  quiz.startQuiz(player);
}
