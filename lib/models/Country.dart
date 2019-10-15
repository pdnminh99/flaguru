import 'dart:ffi';

import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  String id;
  String name;
  String flag;
  String continent;
  Float ratio;
  String description;

  Country({ @required String id, String name, String flag, String continent, Float ratio, String description}) {
    this.id = id;
    this.name = name;
    this.flag = flag;
    this.continent = continent;
    this.ratio = ratio;
    this.description = description;
  }

  Answer toAnswer({isCorrect: false}) {
    return Answer(country: this.name, imageUrl: this.flag, isRight: isCorrect);
  }

  Question toQuestion() {
    return Question(this);
  }

}
