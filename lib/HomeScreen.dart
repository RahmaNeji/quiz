// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:quiz/QuizScreen.dart';
import 'package:quiz/constante.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
            },
            child: Image.asset("assets/Quiz.png")),
      ),
    );
  }
}
