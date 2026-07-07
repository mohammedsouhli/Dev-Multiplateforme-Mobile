import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';
import 'score.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  int score = 0;

  final quiz = const [
    {
      'question':
          'Q 1 - Which of the following is correct about Java 8 lambda expression ?',
      'answers': [
        {
          'answer':
              'A - Using lambda expression, you can refer to final variable or effectively final variable (which is assigned only once)',
          'correct': false,
        },
        {
          'answer':
              'B - Lambda expression throws a compilation error, if a variable is assigned a value the second time ?',
          'correct': false,
        },
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    },
    {
      'question':
          'Q 8 - Which of the following is the correct lambda expression which add two numbers and return their sum?',
      'answers': [
        {
          'answer': 'A - (int a, int b) -> { return a + b;};',
          'correct': false,
        },
        {'answer': 'B - (a, b) -> {return a + b;};', 'correct': false},
        {'answer': 'C - Both of the above.', 'correct': true},
        {'answer': 'D - None of the above.', 'correct': false},
      ],
    },
  ];

  void handleAnswer(Map<String, Object> answer) {
    if (answer['correct'] == true) ++score;
    setState(() {
      ++currentQuestionIndex;
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return currentQuestionIndex >= quiz.length
        ? Score(score, resetQuiz, quiz.length)
        : SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Question(
                  quiz[currentQuestionIndex]['question'] as String,
                  currentQuestionIndex,
                  quiz.length,
                ),
                ...(quiz[currentQuestionIndex]['answers']
                        as List<Map<String, Object>>)
                    .map((answer) => Answer(answer, handleAnswer)),
              ],
            ),
          );
  }
}
