import 'dart:ffi';

import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Question.dart';

class Country {
  int id;
  String name;
  String flag;
  int ratio;
  int _callCounter;
  int _correctCounter;
  String description;
  int chances = 0;
  int nodeAddress;

  Country(
      {@required this.id,
      this.name,
      this.flag,
      this.description,
      int callCounter: 0,
      int correctCounter: 0,
      @required this.chances}) {
    _callCounter = callCounter;
    _correctCounter = correctCounter;
    ratio = (_correctCounter / _callCounter * 100).round();
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

//  void call() {
//    if (chances == 0)
//      chances = 2;
//    else
//      chances -= 1;
//  }

  @override
  String toString() {
    return 'id $id: $name; chance: $chances.\n';
  }
}
