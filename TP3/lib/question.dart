import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;
  final int currentQuestionIndex;
  final int numberOfQuestions;

  const Question(
    this.questionText,
    this.currentQuestionIndex,
    this.numberOfQuestions, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${currentQuestionIndex + 1}/$numberOfQuestions',
          style: const TextStyle(fontSize: 22),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Text(
            questionText,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
