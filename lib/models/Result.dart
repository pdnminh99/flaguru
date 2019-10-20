import 'package:flaguru/models/Enum.dart';
import 'package:flutter/cupertino.dart';

class Result {
  int get score {
    int currentscore =
        this.totaltime * 10 + this.correctAnswers * 20 + this.remainLives * 30;
    switch (this.level) {
      case Difficulty.HARD:
        currentscore *= 3;
        return currentscore;
      case Difficulty.NORMAL:
        currentscore *= 2;
        return currentscore;
      default:
        return currentscore;
    }
  }

  int totaltime;

  int questionsCounter;
  int correctAnswers;
  int get wrongAnswers {
    return this.questionsCounter - this.correctAnswers;
  }

  Difficulty level;
  int remainLives;
  int totalLives;
  Result(
      {@required this.level,
      @required this.totaltime,
      @required this.correctAnswers,
      @required this.questionsCounter,
      @required this.remainLives,
      @required this.totalLives}) {
    if (this.correctAnswers > this.questionsCounter)
      throw Exception(
          "Why would correct answers greater than number of questions?");
    if (this.totalLives < 1)
      throw Exception("Total lives should greater than 0");
    if (this.remainLives > this.totalLives)
      throw Exception("Remain lives should not greater than total lives");
  }

  @override
  String toString() =>
      "level $level in $totaltime secs with $correctAnswers/$questionsCounter correct answers => $score score";
}
