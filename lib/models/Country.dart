import 'dart:ffi';

import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  int id;
  String name;
  String flag;
  int ratio;

  // double get ratio => this._ratio;
  // set ratio(double ratio) => this._ratio = ratio;
  String description;
  int chances = 0;
  // int callCounter = 0;
  // int correctCounter = 0;

  Country(
      {@required this.id,
      this.name,
      this.flag,
      this.description,
      this.chances,
      this.ratio});

  Answer toAnswer() => Answer(
      countryID: this.id,
      country: this.name,
      imageUrl: this.flag,
//        isRight: isCorrect,
      description: this.description);

  Question toQuestion() => Question(this);

  void call() {
    if (this.chances == 0)
      this.chances = 2;
    else
      this.chances -= 1;
  }

  @override
  String toString() {
    return 'id $id: $name\n';
  }
}
