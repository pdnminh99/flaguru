import 'dart:math';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flutter/widgets.dart';

import 'Answer.dart';
import 'Country.dart';
import 'Question.dart';

class QuestionProvider {
  Difficulty _level;

  set level(Difficulty newLevel) {
    this._level = newLevel;
  }

  Difficulty get level => this._level;

  var _countries = List<Country>();
  var _rand = Random();

  QuestionProvider._internal();

  static QuestionProvider questionProviderInstance;

  static Future<QuestionProvider> getInstance({Difficulty level: Difficulty.EASY}) async {
    if (questionProviderInstance == null) {
      print('Found no instance of questionProvider, initialize new one');
      questionProviderInstance = QuestionProvider._internal();
      var database = DatabaseConnector();
      questionProviderInstance.level = level;
      questionProviderInstance._countries = await database.collectCountries();
    } else {
      print('Found an instance of questionProvider.');
    }
    return questionProviderInstance;
  }

  ///
  ///   @param int numberOfQuestions: modify number of questions return by the function, default is 20.
  ///*  @param bool isFirstAnswerCorrect: if this is true, answer One is always true. Easier for debugging purposes.
  ///
  List<Map<String, Object>> getCollections({int numOfQtn: 20, bool isFirstAnswerCorrect: false}) {
    var collections = List<Map<String, Object>>();
    for (var counter = 0; counter < numOfQtn; counter++) {
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
      var c = this._countries[this._rand.nextInt(this._countries.length)];
      if (this._isExisted(candidates, country) || c.id == country.id) continue;
      candidates.add(c.toAnswer(isCorrect: false));
    }
    if (isFirstAnswerCorrect) {
      candidates[0] = country.toAnswer(isCorrect: true);
    } else {
      candidates[this._rand.nextInt(questionCounter)] = country.toAnswer(isCorrect: true);
    }
    return candidates;
  }

  bool _isExisted(List<Answer> answers, Country country) {
    for (var answer in answers) {
      if (answer.country == country.name) return true;
    }
    return false;
  }

  Map<String, Object> _parseQA({@required Country country, bool isFirstAnswerCorrect: false}) {
    return {
      'question': Question(country),
      'answer':
          this._getAnswerCollections(country: country, isFirstAnswerCorrect: isFirstAnswerCorrect)
    };
  }
}
