import 'package:flutter/material.dart';

import '../models/Rule.dart';
import '../models/Answer.dart';
import '../screens/result_screen.dart';
import '../models/RoundHandler.dart';
import 'global_audio_player.dart';
import 'watch_provider.dart';

class RoundProvider with ChangeNotifier {
  Rule rule;
  RoundHandler roundHandler;
  bool isOver = false;

  int index = 0;
  bool isAnswered;
  List<bool> pressStates;

  WatchProvider timer;

  RoundProvider(difficulty) {
    rule = Rule(difficulty);
    RoundHandler.getInstance(
      level: difficulty,
      lifeCount: rule.maxLife,
      timeLimit: rule.timeLimit,
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
    audioPlayer.playSoundLetsGo();
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
    roundHandler.verifyAnswer(timeLeft: timer.time, answer: getUserAnswer());
    if (index + 1 == rule.quizTotal) isOver = true;
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
    timer.periodic(rule.timeLimit, 1, () {
      if (timer.time < 10 && timer.time > 0) audioPlayer.playSoundTick();
      if (timer.time == 0) doWrong();
    });
  }

  void onOver(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ResultScreen(roundHandler.getResult())));
  }

  Answer getUserAnswer() {
    final index = pressStates.indexOf(true);
    if (index == -1) return null;
    return roundHandler.answers[index];
  }

  bool get nameOrFlag => index % 2 == 1;

  List<AnswerUI> get answerSet =>
      roundHandler.answers.map((a) => AnswerUI(a, roundHandler.question)).toList();
}
