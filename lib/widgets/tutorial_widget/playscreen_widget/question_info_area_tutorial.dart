import 'package:flaguru/utils/round_provider.dart';
import 'package:flaguru/widgets/info_area.dart';
import 'package:flaguru/widgets/question_area.dart';
import 'package:flaguru/widgets/tutorial_widget/style_tutorial/textstyle_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';

class QuestionInfoAreaTutorial extends StatelessWidget {
  final int millis;
  final double height;
  final double width;
  final GlobalKey questionkey;
  final GlobalKey infokey;
  final TextStyleTutorial styleshowcase = TextStyleTutorial();
  QuestionInfoAreaTutorial(
      this.questionkey, this.infokey, this.millis, this.height, this.width);
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isAnswered = round.isAnswered;

    return AnimatedContainer(
        width: isAnswered ? width * 0.9 : width,
        height: isAnswered ? height : height * 0.8,
        duration: Duration(milliseconds: millis),
        decoration: BoxDecoration(
          color: (isAnswered)
              ? const Color(0xff99d8df)
              : Colors.white.withOpacity(0.3),
          borderRadius: (isAnswered)
              ? BorderRadius.circular(10)
              : BorderRadius.circular(0),
        ),
        child: isAnswered
            ? Showcase(
                key: infokey,
                description: "Touch screen to continue",
                descTextStyle: styleshowcase.descstyle,
                title: "Some info this country",
                titleTextStyle: styleshowcase.tiltestyle,
                child: InfoArea(round.roundHandler.question, millis))
            : Showcase(
                key: questionkey,
                title: "This is your question",
                titleTextStyle: styleshowcase.tiltestyle,
                description: "Touch screen to continue",
                descTextStyle: styleshowcase.descstyle,
                child: QuestionArea()));
  }
}
