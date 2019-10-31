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
    if (this.highestScore == null) this.highestScore = 0;
    if (this.winningCount == null) this.winningCount = 0;
    if (this.playedCount == null) this.playedCount = 0;
  }
}
