import 'package:flaguru/models/Enum.dart';
import 'package:flutter/material.dart';

class RoundDetails {
  int highestScore = 0;
  int winningCount = 0;
  int playedCount = 0;
  Difficulty level;

  RoundDetails({
    @required this.level,
    this.highestScore,
    this.winningCount,
    this.playedCount,
  }) {
    this.highestScore ??= 0;
    this.winningCount ??= 0;
    this.playedCount ??= 0;
  }

  @override
  String toString() {
    String message;
    switch (level) {
      case Difficulty.EASY:
        message = 'Level EASY, ';
        break;
      case Difficulty.NORMAL:
        message = 'Level NORMAL, ';
        break;
      case Difficulty.HARD:
        message = 'Level HARD, ';
        break;
      case Difficulty.ENDLESS:
        message = 'Level ENDLESS, ';
        break;
      default:
        message = 'Level UNKNOWN, ';
        break;
    }
    message +=
        'Highest score = $highestScore, Winning Count = $winningCount, playedCount = $playedCount.';
    return message;
  }
}
