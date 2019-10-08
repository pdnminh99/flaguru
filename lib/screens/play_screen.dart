import 'dart:async';

import 'package:flaguru/data/question_answers.dart';
import 'package:flaguru/widgets/flag_answers_set.dart';
import 'package:flaguru/widgets/question_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flaguru/widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
  static String routeName = '/play_screen';

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  bool isAnswered;
  List<bool> pressStates;
  num time;
  Timer timer;
  int index;

  @override
  void initState() {
    index = 0;
    initData();
    super.initState();
  }

  void initData() {
    isAnswered = false;
    pressStates = [false, false, false, false];
    time = 10;
    timer = getTimer();
  }

  void changePressState(int i) {
    pressStates[i] = true;
  }

  void doRight() {
    timer.cancel();
    setState(() {
      isAnswered = true;
    });
  }

  void doWrong() {
    timer.cancel();
    setState(() {
      isAnswered = true;
    });
  }

  void refreshBoard() {
    timer.cancel();
    setState(() {
      index = (index + 1) % 3;
      initData();
    });
  }

  Timer getTimer() {
    return Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => time--);
      if (time == 0) doWrong();
    });
  }

  @override
  Widget build(BuildContext context) {
    var qa = DUMMY_QA;
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
              isName: true,
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
            child: FlagAnswersSet(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (isAnswered)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: RaisedButton(
                      onPressed: refreshBoard,
                      child: Text('Next'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
