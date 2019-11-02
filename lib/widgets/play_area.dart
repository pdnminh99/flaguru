import 'package:flutter/material.dart';

import 'info_bar.dart';
import 'answers_area.dart';
import 'bottom_bar.dart';
import 'question_info_area.dart';
import 'count_down_watch_area.dart';

class PlayArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 7, child: InfoBar()),
        Expanded(flex: 40, child: buildQuestionAreaAndWatch()),
        Expanded(flex: 35, child: AnswersArea()),
        Expanded(flex: 11, child: BottomBar()),
      ],
    );
  }

  Widget buildQuestionAreaAndWatch() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final millis = 400;
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            QuestionInfoArea(millis: millis, height: height, width: width),
            CountDownWatchArea(millis: millis, height: height, width: width),
          ],
        );
      },
    );
  }
}
