import 'dart:math';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
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
    this._ratio = country.ratio;
  }

  bool insert(Country country) {
    if (country.ratio != ratio) return false;
    _countries.insert(_rand.nextInt(_countries.length), country);
    return true;
  }

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
    var queue = Map<int, int>();
    while (_cursor < _countries.length && _countries[_cursor].chances != 0) {
      if (_cursor < _countries.length) {
        _countries[_cursor].walkthrough();
        queue[_countries[_cursor].id] = _countries[_cursor].chances;
      }
      _cursor++;
    }
    if (_cursor >= _countries.length) {
      _cursor = 0;
      _updateChancesInDatabase(queue);
      return null;
    }
    var selectedQuestion = _countries[_cursor].toQuestion();
    _countries[_cursor].chances = 5;
    queue[_countries[_cursor].id] = _countries[_cursor].chances;
    _updateChancesInDatabase(queue);
    _cursor++;
    return selectedQuestion;
  }

  void _updateChancesInDatabase(Map<int, int> queue) {
    DatabaseConnector.getInstance().then((db) {
      for (var key in queue.keys)
        db.addUpdateChancesTransaction(countryID: key, chances: queue[key]);
      return db.commitUpdateChancesTransaction();
    }).catchError((error) => print(error));
  }

  Answer getRandomAnswer() =>
      _countries[_rand.nextInt(_countries.length)].toAnswer();
}
