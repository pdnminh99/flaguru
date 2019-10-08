import 'package:flutter/material.dart';

import "../models/Answer.dart";
import 'flag_button.dart';

class FlagAnswersSet extends StatelessWidget {
  final List<Answer> answers;
  final bool isAnswered;
  final Function doRight;
  final Function doWrong;
  final List<bool> pressStates;
  final Function changePressState;

  FlagAnswersSet({
    @required this.answers,
    @required this.isAnswered,
    @required this.doRight,
    @required this.doWrong,
    @required this.pressStates,
    @required this.changePressState,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var halfWidth = constraint.maxWidth * 0.85 / 2;

      var spacingWidget = SizedBox(
        height: constraint.maxWidth * 0.05,
        width: constraint.maxWidth * 0.05,
      );

      Widget getFlagButton(int index) => FlagButton(
            width: halfWidth,
            answer: answers[index],
            doRight: doRight,
            doWrong: doWrong,
            isAnswered: isAnswered,
            isPressed: pressStates[index],
            changePressState: () => changePressState(index),
          );

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getFlagButton(0),
              spacingWidget,
              getFlagButton(1),
            ],
          ),
          spacingWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getFlagButton(2),
              spacingWidget,
              getFlagButton(3),
            ],
          )
        ],
      );
    });
  }
}
