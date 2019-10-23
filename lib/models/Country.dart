import 'dart:ffi';

import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  int id;
  String name;
  String flag;
  double ratio;
  String description;

  Country(
      {@required this.id, this.name, this.flag, this.ratio, this.description});

  Answer toAnswer({isCorrect: false}) {
    return Answer(
        countryID: this.id,
        country: this.name,
        imageUrl: this.flag,
        isRight: isCorrect,
        description: this.description);
  }

  Question toQuestion() {
    return Question(this);
  }

  @override
  String toString() {
    return 'id $id: $name\n';
  }
}
