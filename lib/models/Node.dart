import 'dart:math';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Question.dart';

class Node {
  var _countries = List<Country>();
  int _ratio = 0;
  int _cursor = 0;
  var _rand = Random();

  /*
   * These function is for test only.
   */
  List<Country> testCountries() => this._countries;

  int testRatio() => this._ratio;

  int testCursor() => this._cursor;

  int get ratio => this._ratio;

  Node(Country country) {
    this._countries.add(country);
    // print('Ratio is $ratio');
    this._ratio = country.ratio;
  }

  bool insert(Country country) {
    if (country.ratio != this.ratio) return false;
    this._countries.add(country);
    return true;
  }

  // turn this function to private after test.
  //  int moveCursor() {
  //    var currentCursor = this._cursor;
  //    this._cursor++;
  //    if (this._cursor >= this._countries.length) this._cursor = 0;
  //    return currentCursor;
  //  }

  bool isEmpty() => this._countries.length == 0;

  @override
  String toString() {
    String message = "Node $_ratio has ${_countries.length} countries:\n";
    for (var country in this._countries) message += "> ${country.toString()}";
    return message;
  }

  /*
   * If this returns a null -> no question found. 
   */

  Question getQuestion() {
    while (_cursor < _countries.length && _countries[_cursor].chances != 0) {
      if (_cursor < _countries.length) _countries[_cursor].walkthrough();
      _cursor++;
//      if (_cursor >= _countries.length) {
//        _cursor = 0;
//        return null;
//      }
    }
    if (_cursor >= _countries.length) {
      _cursor = 0;
      return null;
    }
    var selectedQuestion = _countries[_cursor].toQuestion();
    _countries[_cursor].chances = 2;
    _cursor++;
    return selectedQuestion;
  }

  Answer getRandomAnswer() =>
      _countries[_rand.nextInt(_countries.length)].toAnswer();
}
