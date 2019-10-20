import 'dart:async';

import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/Question.dart';
import 'package:flaguru/models/RoundHandler.dart';
import 'package:flaguru/screens/result_screen.dart';
import 'package:flaguru/utils/enum_string.dart';
import 'package:flaguru/widgets/info_bar.dart';
import 'package:flaguru/widgets/loading_spinner.dart';
import 'package:flaguru/widgets/play_screen_drawer.dart';
import 'package:flaguru/widgets/question_info_area.dart';
import 'package:flaguru/widgets/start_button.dart';
import 'package:flaguru/widgets/top_bar.dart';
import 'package:flutter/material.dart';

import 'package:flaguru/models/QuestionProvider.dart';
import 'package:flaguru/widgets/answers_area.dart';
import 'package:flaguru/widgets/bottom_bar.dart';
import 'package:flaguru/widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
  static String routeName = '/play_screen';
  final Difficulty difficulty = Difficulty.EASY;

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  static final int timeLimit = 15;
  static final int maxLife = 5;
  RoundHandler roundHandler;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  int time;
  Timer _timer;

  List<Map<String, Object>> qaList = [];

  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    var qProvider = QuestionProvider(level: widget.difficulty);
    qProvider.initializeQuestionsProvider().then((_) {
      setState(() {
        qaList = qProvider.getCollections(
            numberOfQuestions: 20, isFirstAnswerCorrect: true);
        roundHandler = RoundHandler(
          level: widget.difficulty,
          lifecount: maxLife,
          countdown: timeLimit,
          questions: qaList.length,
        );
      });
    });

    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startGame() {
    setState(() {
      roundHandler.start();
      initData();
    });
    Timer(Duration(milliseconds: 500), _operate);
  }

  void _operate() {
    _timer = getTimer();
    _controller.value = 0;
    _controller.forward();
  }

  void initData() {
    isAnswered = false;
    pressStates = [false, false, false, false];
    time = timeLimit;
  }

  void changePressState(int i) => pressStates[i] = true;

  void doRight() {
    _timer.cancel();
    setState(() {
      roundHandler.getAnswer(
          isCorrect: true,
          questionCountry: (qaList[index]['question'] as Question).countryID,
          countdownRemain: time);

      isAnswered = true;
    });
  }

  void doWrong() {
    _timer.cancel();
    setState(() {
      roundHandler.getAnswer(
          isCorrect: false,
          questionCountry: (qaList[index]['question'] as Question).countryID,
          countdownRemain: time);
      isAnswered = true;
    });
  }

  void getNextQuestion() {
    _timer.cancel();
    _operate();
    setState(() {
      index++;
      initData();
    });
  }

  void onOver() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultScreen(roundHandler.result)));
//    Navigator.of(context).pushReplacementNamed(PlayScreen.routeName,
//        arguments: widget.difficulty);
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
    var width = MediaQuery.of(context).size.width;
    var millis = 500;

    return Scaffold(
      backgroundColor: Color(0xff019dad),
      drawer: PlayScreenDrawer(
        difficulty: widget.difficulty,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: height * 0.09,
              child: TopBar(
                difficulty: EnumString.getDifficulty(widget.difficulty),
              ),
            ),
            if (roundHandler == null)
              Container(
                width: double.infinity,
                height: height * 0.91,
                child: LoadingSpinner(),
              ),
            if (roundHandler != null && roundHandler.status == RoundStatus.IDLE)
              Container(
                width: double.infinity,
                height: height * 0.91,
                child: StartButton(onStart: startGame),
              ),
            if (roundHandler != null &&
                roundHandler.status != RoundStatus.IDLE) ...[
              Container(
                width: double.infinity,
                height: height * 0.07,
                child: InfoBar(
                  totalQuestions: qaList.length,
                  currentQuestion: index + 1,
                  maxLives: maxLife,
                  remainLives: roundHandler.remainLives,
                ),
              ),
              QuestionInfoArea(
                isAnswered: isAnswered,
                isName: nameOrFlag(),
                height: height,
                width: width,
                millis: millis,
                question: qaList[index]['question'],
              ),
              AnimatedContainer(
                width: (isAnswered) ? width * 0.2 : width,
                height: (isAnswered) ? height * 0 : height * 0.09,
                duration: Duration(milliseconds: millis),
                child: CountdownWatch(
                  time: time,
                  redTime: timeLimit - 5,
                ),
              ),
              Container(
                width: double.infinity,
                height: height * 0.35,
                child: FadeTransition(
                  opacity: _controller,
                  child: AnswersArea(
                    isFlag: nameOrFlag(),
                    isAnswered: isAnswered,
                    doRight: doRight,
                    doWrong: doWrong,
                    answers: qaList[index]['answer'],
                    pressStates: pressStates,
                    changePressState: changePressState,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: height * 0.11,
                child: BottomBar(
                  isAnswered: isAnswered,
                  onRefresh: getNextQuestion,
                  isOver: roundHandler.status == RoundStatus.OVER,
                  onOver: onOver,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
