import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';

import '../models/Answer.dart';
import '../screens/result_screen.dart';
import '../models/QuestionProvider.dart';
import '../models/RoundHandler.dart';
import 'global_audio_player.dart';
import 'watch_provider.dart';

class RoundProvider with ChangeNotifier {
  final qtnTotal = 20;
  final timeLimit = 15;
  final maxLife = 5;
  RoundHandler roundHandler;

  int index;
  bool isAnswered;
  List<bool> pressStates;

  WatchProvider timer;

  List<Map<String, Object>> qaList = [];

  RoundProvider(level) {
    QuestionProvider.getInstance(level: level).then(setQaList);
    timer = WatchProvider();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void setQaList(QuestionProvider qProvider) {
    qaList = qProvider.getCollections(numOfQtn: qtnTotal, isFirstAnswerCorrect: true);
    roundHandler = RoundHandler(
      level: qProvider.level,
      lifeTotal: maxLife,
      timeLimit: timeLimit,
      numOfQtn: qtnTotal,
    );
    resetData();
    notifyListeners();
  }

  void startGame() {
    roundHandler.start();
    setTimer();
    notifyListeners();
  }

  void resetData() {
    index = 0;
    setDataAfterAnswered();
  }

  void changePressState(int i) {
    pressStates[i] = true;
    notifyListeners();
  }

  void doRight() {
    processAfterAnswered(true);
    audioPlayer?.playSoundRight();
  }

  void doWrong() {
    processAfterAnswered(false);
    audioPlayer?.playSoundWrong();
  }

  void processAfterAnswered(bool isCorrect) {
    timer.cancel();
    roundHandler.getAnswer(
        isCorrect: isCorrect, question: qaList[index]['question'], timeLeft: timer.time);
    isAnswered = true;
    notifyListeners();
  }

  void getNextQuestion() {
    setTimer();
    index++;
    setDataAfterAnswered();
    notifyListeners();
  }

  void setDataAfterAnswered() {
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
        context, MaterialPageRoute(builder: (context) => ResultScreen(roundHandler.result)));
    print('remain: ${roundHandler.remainQuestions}  ${roundHandler.remainLives}');
  }

  bool get nameOrFlag => index % 2 == 1;

  List<Answer> get answerSet => qaList.isEmpty ? [] : qaList[index]['answer'];

  Question get question => qaList.isEmpty ? null : qaList[index]['question'];
}
