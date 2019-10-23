import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flutter/cupertino.dart';

class Result {
  int get score {
    int currentScore =
        this.totalTimeLeftRightAnswers * 1 + this.correctAnswers * 20 + this.remainLives * 30;
    switch (this.level) {
      case Difficulty.HARD:
        currentScore *= 3;
        return currentScore;
      case Difficulty.NORMAL:
        currentScore *= 2;
        return currentScore;
      default:
        return currentScore;
    }
  }

  final int totalTimeLeftRightAnswers;
  final int totalTimeElapsed;

  final int questionsCounter;
  final int correctAnswers;

  int get wrongAnswers {
    return this.questionsCounter - this.correctAnswers;
  }

  Difficulty level;
  int remainLives;
  int totalLives;
  var answerLogs = List<AnswerLog>();

  Result(
      {@required this.level,
      @required this.totalTimeElapsed,
      @required this.totalTimeLeftRightAnswers,
      @required this.correctAnswers,
      @required this.questionsCounter,
      @required this.remainLives,
      @required this.totalLives,
      @required this.answerLogs}) {
    if (this.correctAnswers > this.questionsCounter)
      throw Exception("Why would correct answers greater than number of questions?");
    if (this.totalLives < 1) throw Exception("Total lives should greater than 0");
    if (this.remainLives > this.totalLives)
      throw Exception("Remain lives should not greater than total lives");
  }

  @override
  String toString() =>
      "level $level in $totalTimeLeftRightAnswers secs with $correctAnswers/$questionsCounter correct answers => $score score";
}
