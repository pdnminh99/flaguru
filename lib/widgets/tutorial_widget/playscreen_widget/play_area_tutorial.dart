import 'package:flaguru/widgets/answers_area.dart';
import 'package:flaguru/widgets/bottom_bar.dart';
import 'package:flaguru/widgets/count_down_watch_area.dart';
import 'package:flaguru/widgets/info_bar.dart';
import 'package:flaguru/widgets/play_area.dart';
import 'package:flaguru/widgets/question_info_area.dart';
import 'package:flutter/cupertino.dart';

class PlayAreaTutorial extends PlayArea
{
  @override 
  Widget build(BuildContext context)
  {
    return Column(
      children: <Widget>[
        Expanded(flex: 7, child: InfoBar()),
        Expanded(flex: 40, child: buildQuestionAreaAndWatch()),
        Expanded(flex: 35, child: AnswersArea()),
        Expanded(flex: 11, child: BottomBar()),
      ],
    );
  }
  @override
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