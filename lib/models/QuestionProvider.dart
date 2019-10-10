import 'dart:math';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Country.dart';
import 'Question.dart';

class QuestionProvider {
  Difficulty level;
  var _countries = List<Country>();
  var _rand = Random();

  QuestionProvider({Difficulty level: Difficulty.EASY}) {
    this.level = level;
  }

  Future<void> initializeQuestionsProvider() async {
    var database = DatabaseConnector();
    this._countries = await database.collectCountries();
  }

  /***
   * @param int numberOfQuestions: modify number of questions return by the function, default is 20.
   * @param bool isFirstAnswerCorrect: if this is true, answer One is always true. Easier for debugging purposes.
   */
  List<Map<String, Object>> getCollections(
      {int numberOfQuestions: 20, bool isFirstAnswerCorrect: false}) {
    var collections = List<Map<String, Object>>();
    for (var counter = 0; counter < numberOfQuestions; counter++) {
      collections.add(this._parseQA(
          country: this._countries[this._rand.nextInt(this._countries.length)],
          isFirstAnswerCorrect: isFirstAnswerCorrect));
    }
    return collections;
  }

  List<Answer> _getAnswerCollections(
      {@required Country country, bool isFirstAnswerCorrect: false}) {
    var questionCounter = 4;
    var candidates = List<Answer>();
    while (candidates.length != questionCounter) {
      // print(this._countries);
      var c = this._countries[this._rand.nextInt(this._countries.length)];
      if (this._isExisted(candidates, country) || c.id == country.id) continue;
      candidates.add(c.toAnswer(isCorrect: false));
    }
    if (isFirstAnswerCorrect) {
      candidates[0] = country.toAnswer(isCorrect: true);
    } else {
      candidates[this._rand.nextInt(questionCounter)] =
          country.toAnswer(isCorrect: true);
    }
    return candidates;
  }

  bool _isExisted(List<Answer> answers, Country country) {
    for (var answer in answers) {
      if (answer.country == country.name) return true;
    }
    return false;
  }

  Map<String, Object> _parseQA(
      {@required Country country, bool isFirstAnswerCorrect: false}) {
    return {
      'question': Question(country),
      'answer': this._getAnswerCollections(
          country: country, isFirstAnswerCorrect: isFirstAnswerCorrect)
    };
  }
}
