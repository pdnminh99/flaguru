import 'package:flutter/material.dart';

class ResultScreenAnimation {
  final AnimationController controller;
  Animation<double> titleOpacity;
  Animation<double> resultArea;
  Animation<double> resultButtonArea;
  Animation<double> leaderBoardButton;

  ResultScreenAnimation(this.controller) {
    titleOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.1)));
    resultArea = CurvedAnimation(parent: controller, curve: Interval(0.1, 0.8));
    resultButtonArea =
        CurvedAnimation(parent: controller, curve: Interval(0.8, 0.9));
    leaderBoardButton =
        CurvedAnimation(parent: controller, curve: Interval(0.9, 1));
  }
}
