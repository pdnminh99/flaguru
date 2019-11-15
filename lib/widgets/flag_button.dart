import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/round_provider.dart';

class FlagButton extends StatelessWidget {
  final int answerIndex;
  final num width;

  FlagButton({@required this.answerIndex, @required this.width});

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isAnswered = round.isAnswered;
    final isPressed = round.pressStates[answerIndex];
    final answer = round.answerSet[answerIndex];

    final borderRadius = BorderRadius.circular(5);

    return Stack(
      children: <Widget>[
        Material(
          elevation: (!isAnswered || isPressed) ? 5 : 0,
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Colors.white, width: 1),
            ),
            height: width / 1.7,
            width: width,
            child: ClipRRect(
              borderRadius: borderRadius,
              child: Image.asset(
                answer.imageUrl,
                fit: BoxFit.fill,
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
        if (isAnswered && !isPressed)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Color(0xff019dad).withOpacity(0.5),
              ),
            ),
          ),
        if (isAnswered && answer.isRight) ...buildDotAnnotator(Colors.green[300]),
        if (isAnswered && isPressed && !answer.isRight) ...buildDotAnnotator(Colors.red[300]),
      ],
    );
  }

  List<Widget> buildDotAnnotator(Color color) {
    return [
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.transparent,
          ),
        ),
      ),
      Positioned(
        bottom: 4,
        right: 4,
        child: Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(7),
          ),
        ),
      ),
    ];
  }
}
