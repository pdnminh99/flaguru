import 'dart:async';

import 'package:flaguru/data/question_answers.dart';
import 'package:flaguru/widgets/answers_area.dart';
import 'package:flaguru/widgets/bottom_bar.dart';
import 'package:flaguru/widgets/question_area.dart';
import 'package:flutter/material.dart';

import 'package:flaguru/widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
  static String routeName = '/play_screen';

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  static const limit = 15;
  bool isAnswered;
  List<bool> pressStates;
  num time;
  Timer _timer;
  int index = 0;
  var qa = DUMMY_QA;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    isAnswered = false;
    pressStates = [false, false, false, false];
    time = limit;
    _timer = getTimer();
  }

  void changePressState(int i) => pressStates[i] = true;

  void doRight() {
    _timer.cancel();
    setState(() {
      isAnswered = true;
    });
  }

  void doWrong() {
    _timer.cancel();
    setState(() {
      isAnswered = true;
    });
  }

  void refreshBoard() {
    _timer.cancel();
    setState(() {
      index = (index + 1) % qa.length;
      initData();
    });
  }

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => time--);
      if (time == 0) doWrong();
    });
  }

  bool nameOrFlag() => index % 2 == 1;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff019dad),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: height * 0.09,
          ),
          Container(
            width: double.infinity,
            height: height * 0.07,
          ),
          Container(
            width: double.infinity,
            height: height * 0.29,
            child: QuestionArea(
              isName: nameOrFlag(),
              question: qa[index]['question'],
            ),
          ),
          Container(
            width: double.infinity,
            height: height * 0.09,
            child: CountdownWatch(time: time),
          ),
          Container(
            width: double.infinity,
            height: height * 0.35,
            child: AnswersArea(
              isFlag: nameOrFlag(),
              isAnswered: isAnswered,
              doRight: doRight,
              doWrong: doWrong,
              answers: qa[index]['answers'],
              pressStates: pressStates,
              changePressState: changePressState,
            ),
          ),
          Container(
            width: double.infinity,
            height: height * 0.11,
            child: BottomBar(
              isAnswered: isAnswered,
              onRefresh: refreshBoard,
            ),
          ),
        ],
      ),
    );
  }
}
