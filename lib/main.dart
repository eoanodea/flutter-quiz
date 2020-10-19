import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<bool> scoreKeeper = [];
  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];
  List<bool> answers = [false, true, true];

  /// Adds an icon as either a check or a close icon
  /// to the [scoreKeeper] list
  /// depending on what the user provides
  void addScore(bool isCheck) {
    bool result = false;
    if (isCheck == answers[scoreKeeper.length]) result = true;

    //   result = Icon(Icons.check, color: Colors.green);
    // else
    //   result = Icon(Icons.close, color: Colors.red);

    setState(() => scoreKeeper.add(result));
  }

  void reset() {
    setState(() => scoreKeeper.clear());
  }

  Widget renderAnswerPage() {
    int result = 0;
    int numOfQuestions = questions.length;
    scoreKeeper.forEach((el) => {if (el) result++});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Your Score:",
          style: TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Container(
            alignment: Alignment.center,
            child: ListTile(
              title: Text(
                "$result / $numOfQuestions",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text("Answers correct"),
            ),
          ),
        ),
        FlatButton(
            color: Colors.blue,
            child: Text(
              'Start Again',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => reset()),
      ],
    );
  }

  renderScore() {
    List<Widget> result = [];
    scoreKeeper.forEach((score) {
      if (score == true)
        result.add(Icon(Icons.check, color: Colors.green));
      else
        result.add(Icon(Icons.close, color: Colors.red));
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (scoreKeeper.length == questions.length) return renderAnswerPage();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[scoreKeeper.length],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => addScore(true)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => addScore(false)),
          ),
        ),
        Row(children: renderScore())
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,


 'You can lead a cow down stairs but not up stairs.', false,
 'Approximately one quarter of human bones are in the feet.', true,
 'A slug\'s blood is green.', true,
*/
