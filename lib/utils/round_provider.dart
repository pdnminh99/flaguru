import 'package:flutter/material.dart';

import '../models/Answer.dart';
import '../screens/result_screen.dart';
import '../models/RoundHandler.dart';
import '../models/Question.dart';
import 'global_audio_player.dart';
import 'watch_provider.dart';

class RoundProvider with ChangeNotifier {
  final quizTotal = 20;
  final timeLimit = 15;
  final maxLife = 5;

  RoundHandler roundHandler;
  bool isOver = false;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  WatchProvider timer;

  RoundProvider(level) {
    RoundHandler.getInstance(
      level: level,
      lifeCount: maxLife,
      timeLimit: timeLimit,
      isFirstAnswerAlwaysRight: true,
    ).then((handler) {
      roundHandler = handler;
      setNewData();
      startGame();
    });

    timer = WatchProvider();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startGame() {
    roundHandler.start();
    setTimer();
    notifyListeners();
  }

  void changePressState(int i) {
    pressStates[i] = true;
    notifyListeners();
  }

  void doRight() {
    processAfterAnswered(true);
    audioPlayer.playSoundRight();
  }

  void doWrong() {
    processAfterAnswered(false);
    if (roundHandler.isAlive) {
      audioPlayer.playSoundWrong();
    } else {
      audioPlayer.playSoundGameOver();
      isOver = true;
    }
  }

  void processAfterAnswered(bool isCorrect) {
    timer.cancel();
    isAnswered = true;
    if (index + 1 == quizTotal) isOver = true;
    notifyListeners();
  }

  void getNextQuestion() {
    roundHandler.generateQAs();
    setTimer();
    index++;
    setNewData();
    notifyListeners();
  }

  void setNewData() {
    isAnswered = false;
    pressStates = [false, false, false, false];
  }

  void setTimer() {
    timer.periodic(timeLimit, 1, () {
      if (timer.time < 10 && timer.time > 0) audioPlayer.playSoundTick();
      if (timer.time == 0) doWrong();
    });
  }

  void onOver(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ResultScreen(roundHandler.getResult())));
  }

  bool get nameOrFlag => index % 2 == 1;
}
