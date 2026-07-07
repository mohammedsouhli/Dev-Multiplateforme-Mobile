import 'package:flutter/material.dart';
import 'quiz.dart';
import 'weather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TP3 Flutter',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.quiz), text: 'Quiz'),
              Tab(icon: Icon(Icons.cloud), text: 'Weather'),
            ],
          ),
          body: TabBarView(
            children: [
              Quiz(),
              Weather(),
            ],
          ),
        ),
      ),
    );
  }
}
