import 'dart:async';

import 'package:flaguru/widgets/flag_answers_set.dart';
import 'package:flutter/material.dart';

import 'package:flaguru/widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
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
      index = (index + 1) % 2;
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 270),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            color: Color(0xbb019dad),
            child: CountdownWatch(time: time),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            color: Color(0xbb019dad),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: FlagAnswersSet(
                isAnswered: isAnswered,
                doRight: doRight,
                doWrong: doWrong,
                //answers: answers[index],
                pressStates: pressStates,
                changePressState: changePressState,
              ),
            ),
          ),
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
    );
  }
}
