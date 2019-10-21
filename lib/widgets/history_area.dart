import 'package:flaguru/models/user_answer.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HistoryArea extends AnimatedWidget {
  final double initHeight;
  final Function reverseAnim;

  HistoryArea({this.initHeight, this.reverseAnim, Animation<double> controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final heightArea = MediaQuery.of(context).size.height * 0.8;
    final widthArea = MediaQuery.of(context).size.width * 0.8;

    final controller = listenable as Animation<double>;
    final dimensionAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    final contentShowingAnim = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.7, 1)));
    final colorAnim = ColorTween(
            begin: const Color(0xff24b6c5), end: Colors.white.withOpacity(0.6))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInCubic));

    final radius = 10.0;

    return BackdropFilter(
      filter: ui.ImageFilter.blur(
        sigmaX: dimensionAnim.value * 5,
        sigmaY: dimensionAnim.value * 5,
      ),
      child: Container(
        width: widthArea,
        height: initHeight + dimensionAnim.value * (heightArea - initHeight),
        margin: EdgeInsets.only(
            bottom: dimensionAnim.value * heightArea * 1.25 * 0.1),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorAnim.value,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
            bottomLeft: Radius.circular(dimensionAnim.value * radius),
            bottomRight: Radius.circular(dimensionAnim.value * radius),
          ),
        ),
        child: FadeTransition(
          opacity: contentShowingAnim,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildListView(
                  answers[0], widthArea, heightArea * 0.8, dimensionAnim),
              buildBackButton(widthArea, heightArea * 0.07, dimensionAnim),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(UserAnswer answer, double width, double height,
      Animation<double> animation) {
    final tileHeight = height * 0.07;
    final borderRadius = BorderRadius.circular(5);
    return Container(
      height: height,
      width: width,
      child: ListView(
        children: <Widget>[
          Container(
            height: animation.value * tileHeight,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: Colors.green.withOpacity(0.9),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  answer.country,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Colors.white, width: 1))),
                    child: Image.asset(answer.imageURL, height: tileHeight)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackButton(
      double width, double height, Animation<double> animation) {
    return SizedBox(
      width: width,
      height: animation.value * height,
      child: RaisedButton(
        elevation: 3,
        color: const Color(0xff24b6c5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          reverseAnim();
        },
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white.withOpacity(0.9),
          size: animation.value * height * 0.8,
        ),
      ),
    );
  }
}

const answers = [
  UserAnswer('United States of America',
      'assets/images/flag-of-United-States-of-America.png', true),
  UserAnswer('Vietnam', 'assets/images/flag-of-Vietnam.png', false),
  UserAnswer('Vietnam', 'assets/images/flag-of-Vietnam.png', true)
];
