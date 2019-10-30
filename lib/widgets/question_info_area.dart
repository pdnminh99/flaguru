import 'package:flutter/material.dart';

import '../models/Question.dart';
import 'question_area.dart';
import 'info_area.dart';

class QuestionInfoArea extends StatelessWidget {
  final bool isAnswered;
  final bool isName;
  final num width;
  final num height;
  final int millis;
  final Question question;

  QuestionInfoArea({
    @required this.isAnswered,
    @required this.isName,
    @required this.width,
    @required this.height,
    @required this.millis,
    @required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: (isAnswered) ? width * 0.9 : width,
      height: (isAnswered) ? height * 0.38 : height * 0.29,
      duration: Duration(milliseconds: millis),
      decoration: BoxDecoration(
        color: (isAnswered) ? Colors.white.withOpacity(0.6) : Colors.white.withOpacity(0.3),
        borderRadius: (isAnswered) ? BorderRadius.circular(10) : BorderRadius.circular(0),
      ),
      child: (isAnswered)
          ? InfoArea(question: question, millis: millis)
          : QuestionArea(isName: isName, question: question),
    );
  }
}
