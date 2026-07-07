import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Map<String, Object> answer;
  final void Function(Map<String, Object>) handleAnswer;

  const Answer(this.answer, this.handleAnswer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () => handleAnswer(answer),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            answer['answer'] as String,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
