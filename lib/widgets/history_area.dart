import 'dart:math';

import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HistoryArea extends AnimatedWidget {
  final double initHeight;
  final Function reverseAnim;
  final Result result;

  HistoryArea({
    @required this.result,
    @required this.initHeight,
    @required this.reverseAnim,
    @required Animation<double> controller,
  }) : super(listenable: controller);

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
            begin: const Color(0xff24b6c5), end: Colors.white.withOpacity(0.5))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInCubic));

    final radius = 10.0;
    final padding = 12.0;

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
        padding: EdgeInsets.all(padding),
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
                buildListView(result.answerLogs, widthArea,
                    heightArea * 0.93 - padding * 3, dimensionAnim),
              buildBackButton(
                  widthArea - padding * 2, heightArea * 0.07, dimensionAnim),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(List<AnswerLog> logs, double width, double height,
      Animation<double> animation) {
    final tileHeight = height * 1 / 10;
    return Container(
      height: animation.value * height,
      width: double.infinity,
      child: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (BuildContext context, int index) {
          return buildListTile(index, logs[index], tileHeight);
        },
      ),
    );
  }

  Widget buildListTile(int index, AnswerLog log, double height) {
    final padding = 5.0;
    final realHeight = height - padding * 2;
    return Container(
      height: height,
      padding: EdgeInsets.all(padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
              radius: realHeight * 0.35,
              backgroundColor:
                  log.isCorrect ? Colors.green[600] : Colors.red[800],
              child: Icon(
                log.isCorrect ? Icons.done : Icons.clear,
                size: realHeight * 0.5,
              )),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                (index + 1).toString() + '. ' + log.question.country,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: realHeight * 0.45,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: Image.asset(log.question.imageURL,
                  height: realHeight * 0.8, width: realHeight * 0.8 * 1.7),
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
