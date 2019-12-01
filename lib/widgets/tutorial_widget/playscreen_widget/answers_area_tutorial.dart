import 'dart:math';
import 'package:flaguru/utils/round_provider.dart';
import 'package:flaguru/widgets/flag_button.dart';
import 'package:flaguru/widgets/name_button.dart';
import 'package:flaguru/widgets/tutorial_widget/style_tutorial/textstyle_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';

class AnswersAreaTutorial extends StatefulWidget {
  
  final TextStyleTutorial styleshowcase = TextStyleTutorial();
  AnswersAreaTutorial();
  @override
  _AnswersAreaTutorialState createState() => _AnswersAreaTutorialState();
}

class _AnswersAreaTutorialState extends State<AnswersAreaTutorial> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  bool isAnimated = false;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: pi / 2, end: 0.0).animate(_controller);

    _controller.forward();
    isAnimated = true;

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isFlag = round.nameOrFlag;

    if (!round.isAnswered && !isAnimated) {
      _controller.value = 0;
      _controller.forward();
      isAnimated = true;
    }
    if (round.isAnswered) isAnimated = false;

    return LayoutBuilder(
      builder: (context, constraint) {
        final halfWidth = constraint.maxWidth * 0.85 / 2;

        final spacingWidget = SizedBox(
          height: constraint.maxWidth * 0.05,
          width: constraint.maxWidth * 0.05,
        );

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButtonWrapper(isFlag, halfWidth, 0),
                spacingWidget,
                buildButtonWrapper(isFlag, halfWidth, 1),
              ],
            ),
            spacingWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildButtonWrapper(isFlag, halfWidth, 2),
                spacingWidget,
                buildButtonWrapper(isFlag, halfWidth, 3),
              ],
            )
          ],
        );
      },
    );
  }

  Widget buildButtonWrapper(bool isFlag, num width, int index) {
    return AnimatedBuilder(
      animation: animation,
      child: buildButton(isFlag, width, index),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationX(animation.value),
          alignment: FractionalOffset.center,
          child: child,
        );
      },
    );
  }

  Widget buildButton(bool isFlag, num width, int index) {
    return (isFlag)
        ? FlagButton(width: width, answerIndex: index)
        : NameButton(width: width, answerIndex: index);
  }
}