import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Question.dart';

class AnswerLog {
  final Question question;
  final Answer answer;
  final bool isCorrect;
  final int answerTime;

  const AnswerLog(
    this.question,
    this.answer,
    this.isCorrect,
    this.answerTime,
  );
}
