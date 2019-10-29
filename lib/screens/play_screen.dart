import 'dart:async';
import 'package:flutter/material.dart';

import '../models/Enum.dart';
import '../models/Question.dart';
import '../models/RoundHandler.dart';
import '../screens/result_screen.dart';
import '../utils/enum_string.dart';
import '../widgets/info_bar.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/play_screen_drawer.dart';
import '../widgets/question_info_area.dart';
import '../widgets/start_button.dart';
import '../widgets/top_bar.dart';
import '../models/QuestionProvider.dart';
import '../widgets/answers_area.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/countdown_watch.dart';

class PlayScreen extends StatefulWidget {
  static final routeName = '/play_screen';
  final Difficulty difficulty;
  PlayScreen(
    {
      this.difficulty
      
    }
  );
  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with SingleTickerProviderStateMixin {
  final questionTotal = 20;
  final timeLimit = 20;
  final maxLife = 5;
  RoundHandler roundHandler;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  int time;
  Timer _timer;

  List<Map<String, Object>> qaList = [];

  AnimationController _controller;

  @override
  void initState() {
    var qProvider = QuestionProvider(level: widget.difficulty);
    qProvider.initializeQuestionsProvider().then((_) {
      setState(() {
        qaList =
            qProvider.getCollections(numberOfQuestions: questionTotal, isFirstAnswerCorrect: true);
        roundHandler = RoundHandler(
          level: widget.difficulty,
          lifeCount: maxLife,
          timeLimit: timeLimit,
          questions: qaList.length,
        );
      });
    });

    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);

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
    Timer(Duration(milliseconds: 300), _operate);
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
    processAfterAnswered(true);
    // play sound
  }

  void doWrong() {
    processAfterAnswered(false);
    // play sound
  }

  void processAfterAnswered(bool isRightAnswer) {
    _timer.cancel();
    setState(() {
      roundHandler.getAnswer(
          isCorrect: isRightAnswer, question: qaList[index]['question'], timeLeft: time);
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
        context, MaterialPageRoute(builder: (context) => ResultScreen(roundHandler.result)));
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final millis = 500;

    return Scaffold(
      backgroundColor: Color(0xff019dad),
      drawer: PlayScreenDrawer(difficulty: widget.difficulty),
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
            Visibility(
              visible: roundHandler == null,
              child: Container(
                width: double.infinity,
                height: height * 0.91,
                child: LoadingSpinner(),
              ),
            ),
            Visibility(
              visible: roundHandler != null && roundHandler.status == RoundStatus.IDLE,
              child: Container(
                width: double.infinity,
                height: height * 0.91,
                child: StartButton(onStart: startGame),
              ),
            ),
            if (roundHandler != null && roundHandler.status != RoundStatus.IDLE) ...[
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
                child: CountdownWatch(time: time, redTime: 10),
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
