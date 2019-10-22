import 'package:flutter/material.dart';

class HistoryAreaAnimation {
  final Animation<double> controller;
  Animation<double> listDimensionAnim;
  Animation<double> btnDimensionAnim;
  Animation<double> contentShowingAnim;
  Animation<double> bottomMarginAnim;
  Animation<Color> colorAnim;

  HistoryAreaAnimation(this.controller) {
    listDimensionAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 1, curve: Curves.easeIn)));
    btnDimensionAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.3, 1)));
    bottomMarginAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.3, 1)));
    contentShowingAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 1)));
    colorAnim = ColorTween(
            begin: const Color(0xff24b6c5), end: Colors.white.withOpacity(0.5))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }
}
