import 'package:flutter/material.dart';

class ResultAreaAnimation {
  final Animation<double> controller;
  Animation<double> bgOpacity;
  Animation<double> right;
  Animation<double> life;
  Animation<double> time;
  Animation<double> bgPoint;
  Animation<double> point;

  ResultAreaAnimation(this.controller) {
    bgOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.1)));
    right = CurvedAnimation(parent: controller, curve: Interval(0.1, 0.3));
    life = CurvedAnimation(parent: controller, curve: Interval(0.3, 0.45));
    time = CurvedAnimation(parent: controller, curve: Interval(0.45, 0.65));
    bgPoint = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.65, 0.85, curve: Curves.bounceOut)));
    point = CurvedAnimation(parent: controller, curve: Interval(0.75, 1.0));
  }
}
