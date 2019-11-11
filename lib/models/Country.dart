import 'dart:ffi';

import 'package:flaguru/models/Enum.dart';
import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  int id;
  String name;
  String flag;
  Continent continent;
  int ratio;
  int _callCounter;
  int _correctCounter;
  String description;
  int chances = 0;
  bool isAllow = true;
  // int nodeAddress;

  Country(
      {@required this.id,
      this.name,
      this.flag,
      this.description,
      int callCounter: 0,
      int correctCounter: 0,
      this.continent,
      this.isAllow,
      @required this.chances}) {
    _callCounter = callCounter;
    _correctCounter = correctCounter;
    ratio = callCounter == 0 && correctCounter == 0
        ? 0
        : (_correctCounter / _callCounter * 100).round();
    // print('Country $name has new ratio $ratio');
  }

  Answer toAnswer() => Answer(
      countryID: this.id,
      country: this.name,
      imageUrl: this.flag,
      description: this.description);

  Question toQuestion() => Question(this);

  void walkthrough() {
    if (chances > 0)
      chances -= 1;
    else if (chances < 0) throw Exception('Why would chances be negative.');
  }

  void call() => chances = chances == 0 ? 2 : chances - 1;

  int calculateNewRatio(bool isCorrect) {
    _callCounter++;
    if (isCorrect) _correctCounter++;
    ratio = (_correctCounter / _callCounter * 100).round();
    // print('Country $name has new ratio $ratio');
    return ratio;
  }

  @override
  String toString() => '''
    $name -> ratio $ratio -> chance: $chances -> $isAllow.
    ''';
}
