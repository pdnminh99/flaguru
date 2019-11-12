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
    // print('Ratio is $ratio');
    this._ratio = country.ratio;
  }

  bool insert(Country country) {
    if (country.ratio != ratio) return false;
    _countries.insert(_rand.nextInt(_countries.length), country);
//    _countries.add(country);
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
    var sqlDatabase = DatabaseConnector();
    while (_cursor < _countries.length && _countries[_cursor].chances != 0) {
      if (_cursor < _countries.length) {
        _countries[_cursor].walkthrough();
        // update chances
        sqlDatabase
            .updateChances(
                countryID: _countries[_cursor].id,
                chances: _countries[_cursor].chances)
            .then((_) => print(
                'Update ${_countries[_cursor].id} with ${_countries[_cursor].chances} chances'))
            .catchError((error) => print(error));
      }
      _cursor++;
    }
    if (_cursor >= _countries.length) {
      _cursor = 0;
      return null;
    }
    var selectedQuestion = _countries[_cursor].toQuestion();
    _countries[_cursor].chances = 5;
    // print(_countries[_cursor].toString());
    // update chances
    sqlDatabase
        .updateChances(
            countryID: _countries[_cursor].id,
            chances: _countries[_cursor].chances)
        .then((_) => print(
            'Update ${_countries[_cursor].name} with ${_countries[_cursor].chances} chances'))
        .catchError((error) => print(error));
    _cursor++;
    return selectedQuestion;
  }

  Answer getRandomAnswer() =>
      _countries[_rand.nextInt(_countries.length)].toAnswer();

  Country updateCountryStats(int countryID, bool isCorrect) {
    for (int i = 0; i < _countries.length; i++) {
      if (_countries[i].id == countryID) {
        var newRatio = _countries[i].calculateNewRatio(isCorrect);
        var country = _countries[i];
        if (newRatio != ratio) {
          _countries.removeAt(i);
          return country;
        } else
          return null;
      }
    }
    throw Exception('Country with ID $countryID not found in node $ratio');
  }

  // void moveNode(int newNode) {
  //   for (int i = 0; i < _countries.length; i++)
  //     _countries[i].nodeAddress = newNode;
  // }
}
