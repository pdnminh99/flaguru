import 'package:flaguru/models/Enum.dart';
import 'package:flutter/cupertino.dart';

class Result {
  int get score {
    int currentscore = totaltime * 10 + correctAnswers * 20;
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
  int correctAnswers;
  int get wrongAnswers {
    return this.questionsCounter - this.correctAnswers;
  }

  int questionsCounter;
  Difficulty level;

  Result(
      {@required this.level,
      @required this.totaltime,
      @required this.correctAnswers,
      @required this.questionsCounter}) {
    if (this.correctAnswers > this.questionsCounter)
      throw Exception(
          "Why would correct answers greater than number of questions?");
  }

  @override
  String toString() =>
      "level $level in $totaltime secs with $correctAnswers/$questionsCounter correct answers => $score score";
}
