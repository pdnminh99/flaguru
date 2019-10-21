import 'package:flutter/material.dart';

class ResultAreaAnimation {
  final Animation<double> controller;
  Animation<double> bgOpacity;
  Animation<double> right;
  Animation<double> life;
  Animation<double> time;
  Animation<double> bgScore;
  Animation<double> score;
  Animation<double> best;

  ResultAreaAnimation(this.controller) {
    bgOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.05)));
    right = CurvedAnimation(parent: controller, curve: Interval(0.05, 0.25));
    life = CurvedAnimation(parent: controller, curve: Interval(0.25, 0.4));
    time = CurvedAnimation(parent: controller, curve: Interval(0.4, 0.6));
    bgScore = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.6, 0.8, curve: Curves.bounceOut)));
    score = CurvedAnimation(parent: controller, curve: Interval(0.75, 0.95));
    best = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.95, 1)));
  }
}
