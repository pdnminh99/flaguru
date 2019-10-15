import 'dart:async';

import 'package:flaguru/data/question_answers.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/utils/enum_string.dart';
import 'package:flaguru/widgets/info_area.dart';
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
  static const timeLimit = 15;
  static const maxLife = 5;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  int remainLives = maxLife;
  bool isStarted = false;
  bool isOver = false;

  int time;
  Timer _timer;

  List<Map<String, Object>> qaList;

  @override
  void initState() {
//    qa = DUMMY_QA;
    var qProvider = QuestionProvider(level: Difficulty.EASY);
    qProvider.initializeQuestionsProvider().then((_) {
      setState(() => qaList = qProvider.getCollections(
          numberOfQuestions: 20, isFirstAnswerCorrect: true));
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
    time = timeLimit;
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
      if (index == qaList.length - 1) isOver = true;
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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff019dad),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: height * 0.09,
              child: TopBar(
                level: EnumString.getDifficulty(Difficulty.EASY),
              ),
            ),
            if (qaList == null)
              Container(
                width: double.infinity,
                height: height * 0.91,
                child: LoadingSpinner(),
              ),
            if (qaList != null && !isStarted)
              Container(
                width: double.infinity,
                height: height * 0.91,
                child: StartButton(
                  onStart: startGame,
                ),
              ),
            if (qaList != null && isStarted) ...[
              Container(
                width: double.infinity,
                height: height * 0.07,
                child: InfoBar(
                  totalQuestions: qaList.length,
                  currentQuestion: index + 1,
                  maxLives: maxLife,
                  remainLives: remainLives,
                ),
              ),
              AnimatedContainer(
                width: (isAnswered) ? width * 0.9 : width,
                height: (isAnswered) ? height * 0.38 : height * 0.29,
                duration: Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  color: (isAnswered)
                      ? Colors.white.withOpacity(0.6)
                      : Colors.white.withOpacity(0.3),
                  borderRadius: (isAnswered)
                      ? BorderRadius.circular(10)
                      : BorderRadius.circular(0),
                ),
                child: (isAnswered)
                    ? InfoArea(
                        question: qaList[index]['question'],
                      )
                    : QuestionArea(
                        isName: nameOrFlag(),
                        question: qaList[index]['question'],
                      ),
              ),
              AnimatedContainer(
                width: (isAnswered) ? width * 0.7 : width,
                height: (isAnswered) ? height * 0 : height * 0.09,
                duration: Duration(milliseconds: 500),
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
                  answers: qaList[index]['answer'],
                  pressStates: pressStates,
                  changePressState: changePressState,
                ),
              ),
              Container(
                width: double.infinity,
                height: height * 0.11,
                child: BottomBar(
                  isAnswered: isAnswered,
                  onRefresh: getNextQuestion,
                  isOver: isOver,
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
