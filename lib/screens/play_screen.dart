import 'dart:async';

import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/widgets/info_bar.dart';
import 'package:flaguru/widgets/loading_spinner.dart';
import 'package:flaguru/widgets/start_button.dart';
import 'package:flaguru/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import 'package:flaguru/models/QuestionProvider.dart';
import 'package:flaguru/widgets/answers_area.dart';
import 'package:flaguru/widgets/bottom_bar.dart';
import 'package:flaguru/widgets/question_area.dart';
import 'package:flaguru/widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
  static String routeName = '/play_screen';

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  static const limit = 15;
  static const maxLife = 5;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  int remainLives = maxLife;
  bool isStarted = false;
  bool isOver = false;

  int time;
  Timer _timer;

  List<Map<String, Object>> qa;

  @override
  void initState() {
    var qProvider = QuestionProvider(level: Difficulty.EASY);
    qProvider.initializeQuestionsProvider().then((_) {
      setState(() => qa = qProvider.getCollections(numberOfQuestions: 50, isFirstAnswerCorrect: false));
    });
    super.initState();
  }

  void startGame() {
    isStarted = true;
    initData();
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
      remainLives--;
      isAnswered = true;
      if (remainLives == 0) isOver = true;
    });
  }

  void getNextQuestion() {
    _timer.cancel();
    setState(() {
      index++;
      initData();
      if (index == qa.length - 1) isOver = true;
    });
  }

  void onOver() {
    // navigate to the result screen
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
            child: TopBar(
              level: "easy",
            ),
          ),
          if (qa == null)
            Container(
              width: double.infinity,
              height: height * 0.91,
              child: LoadingSpinner(),
            ),
          if (qa != null && !isStarted)
            Container(
              width: double.infinity,
              height: height * 0.91,
              child: StartButton(
                onStart: startGame,
              ),
            ),
          if (qa != null && isStarted) ...[
            Container(
              width: double.infinity,
              height: height * 0.07,
              child: InfoBar(
                totalQuestions: qa.length,
                currentQuestion: index + 1,
                maxLives: maxLife,
                remainLives: remainLives,
              ),
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
                answers: qa[index]['answer'],
                pressStates: pressStates,
                changePressState: changePressState,
              ),
            ),
            Container(
              width: double.infinity,
              height: height * 0.11,
              child: BottomBar(
                isAnswered: isAnswered,
                isOver: isOver,
                onRefresh: getNextQuestion,
                onOver: onOver,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
