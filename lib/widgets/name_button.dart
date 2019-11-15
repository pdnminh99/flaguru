import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/round_provider.dart';

class NameButton extends StatelessWidget {
  final int answerIndex;
  final num width;

  NameButton({@required this.answerIndex, @required this.width});

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isAnswered = round.isAnswered;
    final isPressed = round.pressStates[answerIndex];
    final answer = round.answerSet[answerIndex];
    final tooLong = answer.country.length > 30;

    final borderRadius = BorderRadius.circular(5);

    var bgColor = Colors.white;
    var textColor = Colors.black;

    if (answer.isRight && isAnswered) {
      bgColor = const Color(0xff69b747);
      textColor = Colors.white;
    }
    if (!answer.isRight && isPressed) {
      bgColor = Colors.red[300];
      textColor = Colors.white;
    }

    return Stack(
      children: <Widget>[
        Material(
          elevation: (!isAnswered || isPressed) ? 5 : 0,
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(borderRadius: borderRadius, color: bgColor),
            height: width / 1.7,
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  answer.country,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: (tooLong) ? width / 9 : width / 8,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {
                round.changePressState(answerIndex);
                answer.isRight ? round.doRight() : round.doWrong();
              },
            ),
          ),
        ),
        Visibility(
          visible: isAnswered && !isPressed,
          child: Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: const Color(0xff019dad).withOpacity(0.5),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isAnswered && isPressed,
          child: Positioned.fill(
            child: Container(
              decoration: BoxDecoration(borderRadius: borderRadius, color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
