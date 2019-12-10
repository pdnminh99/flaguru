import 'package:flaguru/widgets/answers_area.dart';
import 'package:flaguru/widgets/bottom_bar.dart';
import 'package:flaguru/widgets/count_down_watch_area.dart';
import 'package:flaguru/widgets/play_area.dart';
import 'package:flaguru/widgets/question_info_area.dart';
import 'package:flaguru/widgets/tutorial_widget/playscreen_widget/bottom_bar_tutorial.dart';
import 'package:flaguru/widgets/tutorial_widget/playscreen_widget/info_bar_tutorial.dart';
import 'package:flaguru/widgets/tutorial_widget/style_tutorial/textstyle_tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'answers_area_tutorial.dart';
import 'count_down_watch_area_tutorial.dart';
import 'question_info_area_tutorial.dart';

class PlayAreaTutorial extends PlayArea {
  final TextStyleTutorial styleshowcase = TextStyleTutorial();
  final List<GlobalKey> listkey;

  PlayAreaTutorial(this.listkey);

  @override
  Widget build(BuildContext context) {
    //delay1(context);
    return Column(
      children: <Widget>[
        Expanded(flex: 7, child: InfoBarTutorial(listkey[0], listkey[1])),
        Expanded(flex: 40, child: buildQuestionAreaAndWatch()),
        Expanded(flex: 35, child: buildAnswersAreaTutorial()),
        Expanded(flex: 11, child: BottomBarTutorial(listkey[5])),
      ],
    );
  }

  void delay1(BuildContext context) {
    Future.delayed(
        Duration(milliseconds: 500), () => ShowCaseWidget.of(context).startShowCase(listkey));
  }

  Widget buildAnswersAreaTutorial() {
    return Showcase(
        key: listkey[3],
        showArrow: false,
        title: "Answer area",
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        description: "Touch to try play",
        descTextStyle: TextStyle(fontSize: 13),
        child: AnswersArea());
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
            QuestionInfoAreaTutorial(listkey[2], listkey[4], millis, height, width),
            CountDownWatchArea(millis: millis, height: height, width: width),
          ],
        );
      },
    );
  }
}
