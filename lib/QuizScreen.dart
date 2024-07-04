import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz/constante.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class Question {
  final String question;
  final List<String> options;
  final int answerIndex;

  Question({
    required this.question,
    required this.options,
    required this.answerIndex,
  });
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> _questions = [
    Question(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      answerIndex: 0,
    ),
    Question(
      question: "What is 2 + 2?",
      options: ["3", "4", "5", "6"],
      answerIndex: 1,
    ),
    Question(
      question: "What is the color of the sky?",
      options: ["Blue", "Green", "Red", "Yellow"],
      answerIndex: 0,
    ),
  ];
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(int answerIndex) {
    if (answerIndex == _questions[_currentQuestionIndex].answerIndex) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
    });
    if (_currentQuestionIndex >= _questions.length) {
      _showResult();
    }
  }

  void _showResult() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Center(child: Text('Quiz Finished')),
        content: Text('Your score is $_score'),
        actions: <Widget>[
          TextButton(
            child: Text('Restart'),
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _currentQuestionIndex = 0;
                _score = 0;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        backgroundColor: bg,
        body: Center(
          child: Text(
            'Loading...',
            style: TextStyle(
                fontSize: 23, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              currentQuestion.question,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(height: 50),
            ...currentQuestion.options.map((option) {
              final optionIndex = currentQuestion.options.indexOf(option);
              return Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .6,
                    child: ElevatedButton(
                      onPressed: () {
                        _answerQuestion(optionIndex);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: grey,
                        shadowColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  if (optionIndex != currentQuestion.options.length - 1)
                    SizedBox(height: 40),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
