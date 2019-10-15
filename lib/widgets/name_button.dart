import 'package:flaguru/models/Answer.dart';
import 'package:flutter/material.dart';

class NameButton extends StatelessWidget {
  final Answer answer;
  final num width;
  final Function doRight;
  final Function doWrong;
  final bool isAnswered;
  final bool isPressed;
  final Function changePressState;

  NameButton({
    @required this.answer,
    @required this.width,
    @required this.doRight,
    @required this.doWrong,
    @required this.isAnswered,
    @required this.isPressed,
    @required this.changePressState,
  });

  @override
  Widget build(BuildContext context) {
    var tooLong = answer.country.length > 30;

    final borderRadius = BorderRadius.circular(5);

    var bgColor = Colors.white;
    var textColor = Colors.black;

    if (answer.isRight && isAnswered) {
      bgColor = Color(0xff69b747);
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
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: bgColor,
              ),
              height: width / 1.7,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    answer.country,
                    style: TextStyle(
                      fontSize: (tooLong)? width / 9 : width / 8,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: () {
                answer.isRight ? doRight() : doWrong();
                changePressState();
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
        if (isAnswered && isPressed)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.transparent,
              ),
            ),
          ),
      ],
    );
  }
}
