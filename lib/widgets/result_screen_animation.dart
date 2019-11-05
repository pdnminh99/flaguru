import 'package:flutter/material.dart';

class ResultScreenAnimation {
  final AnimationController controller;
  Animation<double> titleOpacity;
  Animation<double> resultArea;
  Animation<double> resultButtonArea;
  Animation<Offset> historyBtnOffset;

  ResultScreenAnimation(this.controller) {
    titleOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.05)));
    resultArea = CurvedAnimation(parent: controller, curve: Interval(0.05, 0.9));
    resultButtonArea = CurvedAnimation(parent: controller, curve: Interval(0.9, 1));
    historyBtnOffset = Tween(begin: Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.95, 1)));
  }
}
