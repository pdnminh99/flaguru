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
  });
}
