import 'package:flutter/material.dart';

class HistoryAreaAnimation {
  final Animation<double> controller;
  Animation<double> bgOpacity;
  Animation<double> listAnim;
  Animation<double> btnAnim;
  Animation<double> contentShowingAnim;
  Animation<double> bottomMarginAnim;
  Animation<Color> colorAnim;

  HistoryAreaAnimation(this.controller) {
    bgOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.2, 0.7)));
    listAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    btnAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.3, 1)));
    bottomMarginAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.3, 1)));
    contentShowingAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 1)));
    colorAnim = ColorTween(
            begin: const Color(0xff24b6c5), end: Color(0xeaf2faff))
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }
}
