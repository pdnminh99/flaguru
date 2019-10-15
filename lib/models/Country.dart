import 'dart:ffi';

import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  String id;
  String name;
  String flag;
  double ratio;
  String description;

  Country(
      {@required String id,
      String name,
      String flag,
      double ratio,
      String description}) {
    this.id = id;
    this.name = name;
    this.flag = flag;
    this.ratio = ratio;
    this.description = description;
    // print(this.toString());
  }

  Answer toAnswer({isCorrect: false}) {
    return Answer(
        country: this.name,
        imageUrl: this.flag,
        isRight: isCorrect,
        ratio: this.ratio,
        description: this.description);
  }

  Question toQuestion() {
    return Question(this);
  }

  @override
  String toString() {
    return '$name has ratio $ratio with description $description';
  }
}
