import 'package:flaguru/models/Question.dart';
import 'package:flutter/foundation.dart';

class Answer {
  final int countryID;
  final String imageUrl;
  final String country;

  final String description;

  const Answer({
    @required this.countryID,
    @required this.country,
    @required this.imageUrl,
    @required this.description,
  });

  @override
  String toString() {
    return '$countryID; name $country\n';
  }
}

class AnswerUI {
  String imageUrl;
  String country;
  bool isRight;

  AnswerUI(Answer answer, Question question) {
    imageUrl = answer.imageUrl;
    country = answer.country;
    isRight = answer.countryID == question.countryID;
  }
}
