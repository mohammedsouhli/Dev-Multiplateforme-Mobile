import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final int score;
  final int numberOfQuestions;
  final VoidCallback resetQuiz;

  const Score(this.score, this.resetQuiz, this.numberOfQuestions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Results: Your score is ${(score / numberOfQuestions * 100).toStringAsFixed(1)} %',
            style: const TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: resetQuiz,
            child: const Text(
              'Restart',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
