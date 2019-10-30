import 'package:flutter/material.dart';

import "../models/Answer.dart";
import 'flag_button.dart';
import 'name_button.dart';

class AnswersArea extends StatelessWidget {
  final bool isFlag;
  final List<Answer> answers;
  final bool isAnswered;
  final Function doRight;
  final Function doWrong;
  final List<bool> pressStates;
  final Function changePressState;

  AnswersArea({
    @required this.isFlag,
    @required this.answers,
    @required this.isAnswered,
    @required this.doRight,
    @required this.doWrong,
    @required this.pressStates,
    @required this.changePressState,
  });

  Widget buildButton(int index, num width) {
    if (isFlag)
      return FlagButton(
        width: width,
        answer: answers[index],
        doRight: doRight,
        doWrong: doWrong,
        isAnswered: isAnswered,
        isPressed: pressStates[index],
        changePressState: () => changePressState(index),
      );
    return NameButton(
      width: width,
      answer: answers[index],
      doRight: doRight,
      doWrong: doWrong,
      isAnswered: isAnswered,
      isPressed: pressStates[index],
      changePressState: () => changePressState(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var halfWidth = constraint.maxWidth * 0.85 / 2;

      var spacingWidget = SizedBox(
        height: constraint.maxWidth * 0.05,
        width: constraint.maxWidth * 0.05,
      );

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton(0, halfWidth),
              spacingWidget,
              buildButton(1, halfWidth),
            ],
          ),
          spacingWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton(2, halfWidth),
              spacingWidget,
              buildButton(3, halfWidth),
            ],
          )
        ],
      );
    });
  }
}
