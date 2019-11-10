import 'dart:math';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/Node.dart';
import 'package:flaguru/models/Question.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flaguru/models/Enum.dart';

class RoundHandler {
  DatabaseConnector _sqlDatabase;
  Difficulty _level;

  // Life props
  int _lifeCount = 0;
  int remainLives = 0;

  bool get isAlive => remainLives > 0;

  // Question props
  int _questions = 0;

  int get passedQuestions => _questions;

  // Answers props
  int _correctAnswersCounter = 0;
  var answerLogs = List<AnswerLog>();

  // Timing props
  int _totalTimeElapsed = 0;
  int _totalTimeLeftRightAnswers = 0;
  int _timeLimit;

  // Questions props
  var _countriesChain = List<Node>();

  var answers = List<Answer>();
  Question question;
  bool _isVerified;

  int get _lastIndex => this._countriesChain.length - 1;

  int _easyCursor;
  int _hardCursor;
  int _normalCursor;
  bool _isNormalCursorHeadLeft = true;
  int _distanceFromNormalCursor = 0;

  var _rand = Random();
  bool _isFirstAnswerAlwaysRight;

  static bool isInit() => _handlerInstance != null;

  RoundHandler._internal();

  static RoundHandler _handlerInstance;

  static Future<RoundHandler> getInstance(
      {Difficulty level: Difficulty.EASY,
      int lifeCount: 1,
      int timeLimit: 15,
      bool isFirstAnswerAlwaysRight: false}) async {
    if (_handlerInstance == null) {
      // Handle exceptions.
      if (lifeCount < 1)
        throw Exception("Life count per round should be greater than 0");
      if (timeLimit < 1) throw Exception("countdown time should be at least 1");
      print('Found no instance of RoundHandler, initialize new one');
      _handlerInstance = RoundHandler._internal();
      // initialize default params.
      await _handlerInstance._initializeDefaultParams(
          level, lifeCount, isFirstAnswerAlwaysRight);
    } else {
      print('Found an instance of RoundHandler.');
      // In case where user choose a new difficulty.
      _handlerInstance._initializeStaticParams(
          level, lifeCount, isFirstAnswerAlwaysRight);
    }
    // print(_handlerInstance._countriesChain.toString());
    return _handlerInstance;
  }

  void _initializeStaticParams(
    Difficulty level,
    int lifeCount,
    bool isFirstAnswerAlwaysRight,
  ) {
    // clear old answer logs.
    this.answerLogs.clear();
    // get new variables.
    this._level = level;
    this._lifeCount = lifeCount;
    this.remainLives = lifeCount;
    this._questions = 0;
    this._isFirstAnswerAlwaysRight = isFirstAnswerAlwaysRight;
    // reset cursor.
    this._easyCursor = _lastIndex;
    this._normalCursor = this._lastIndex ~/ 2;
    this._isNormalCursorHeadLeft = true;
    this._distanceFromNormalCursor = 0;
    this._hardCursor = 0;
  }

  Future<void> _initializeDefaultParams(
    Difficulty level,
    int lifeCount,
    bool isFirstAnswerAlwaysRight,
  ) async {
    _initializeStaticParams(level, lifeCount, isFirstAnswerAlwaysRight);
    // collect countries and parse to chain.
    _sqlDatabase = DatabaseConnector();
    (await _sqlDatabase.collectCountries()).forEach((country) {
      if (_countriesChain.length == 0 ||
          _countriesChain[_lastIndex].ratio != country.ratio) {
        country.nodeAddress = _countriesChain.length;
        _createNode(country);
      } else {
        country.nodeAddress = _countriesChain.length - 1;
        // insert by randomizing position.
        _countriesChain[_lastIndex].insert(country);
      }
    });
    generateQAs();
  }

  void _createNode(Country newCountry) {
    _countriesChain.add(Node(newCountry));
    _easyCursor = _lastIndex;
    _normalCursor = _lastIndex ~/ 2;
  }

  void generateQAs() {
    if (remainLives <= 0)
      throw Exception('There is no lives remain to generate new question.');
    _questions += 1;
    answers.clear();
    for (int counter = 0; counter < 4; counter++)
      answers.add(_countriesChain[_rand.nextInt(_countriesChain.length)]
          .getRandomAnswer());
    switch (_level) {
      case Difficulty.UNLIMITED:
      case Difficulty.EASY:
        do {
          question = _countriesChain[_easyCursor].getQuestion();
          if (question == null) _easyCursor--;
          if (_easyCursor < 0) _easyCursor = _lastIndex;
        } while (question == null);
        break;
      case Difficulty.NORMAL:
//        do {
//          var leftCursor = _normalCursor - _distanceFromNormalCursor;
//          var rightCursor = _normalCursor + _distanceFromNormalCursor;
//          if (leftCursor < 0 && rightCursor >= _countriesChain.length)
//            _distanceFromNormalCursor = 0;
//          if (_isNormalCursorHeadLeft) {
//            if (leftCursor < 0) _isNormalCursorHeadLeft = false;
//            question =
//                _countriesChain[_normalCursor + _distanceFromNormalCursor]
//                    .getQuestion();
//          } else {
//
//          }
//          question = _countriesChain[_isNormalCursorHeadLeft
//                  ? _normalCursor - _distanceFromNormalCursor
//                  : _normalCursor + _distanceFromNormalCursor]
//              .getQuestion();
//          if (question == null) _isNormalCursorHeadLeft = false;
//          if (question == null && !_isNormalCursorHeadLeft)
//            _distanceFromNormalCursor++;
//        } while (question == null);
//        break;
      case Difficulty.HARD:
        do {
          question = _countriesChain[_hardCursor].getQuestion();
          if (question == null) _hardCursor++;
          if (_hardCursor >= _countriesChain.length) _hardCursor = 0;
        } while (question == null);
        break;
      default:
        throw Exception('Unknown difficulty');
    }
    if (_isFirstAnswerAlwaysRight)
      answers[0] = question.toAnswer();
    else
      answers[_rand.nextInt(answers.length)] = question.toAnswer();
    _isVerified = false;
  }

  bool verifyAnswer({@required int timeLeft, @required Answer answer}) {
    if (this._timeLimit < timeLeft)
      throw Exception(
          "Why would countdown remain greater than countdown time?");
    final timeElapsed = _timeLimit - timeLeft;
    this._totalTimeElapsed += timeElapsed;
    var isCorrect = answer.countryID == question.countryID;
    // prevent FE from verifying one question more than once.
    if (_isVerified) return isCorrect;
    if (isCorrect) {
      _correctAnswersCounter += 1;
      _totalTimeLeftRightAnswers += timeLeft;
    } else
      remainLives -= 1;
    answerLogs.add(AnswerLog(question, answer, isCorrect, timeElapsed));
    _isVerified = true;
    // save result to database
    //    _sqlDatabase
    //        .updateCountryStats(question.countryID, isCorrect)
    //        .catchError((error) => print(error));
    return isCorrect;
  }

  void start() {
    LocalStorage.newRound(this._level)
        .then((_) => print('New round is started'))
        .catchError((error) => print(error));
  }

  Result getResult() {
    var roundResult = Result(
        level: this._level,
        totalTimeElapsed: this._totalTimeElapsed,
        totalTimeLeftRightAnswers: this._totalTimeLeftRightAnswers,
        correctAnswers: this._correctAnswersCounter,
        questionsCounter: this.passedQuestions,
        remainLives: this.remainLives,
        totalLives: this._lifeCount,
        answerLogs: this.answerLogs);
    LocalStorage.saveResult(
            roundResult.score, this._level, this.remainLives > 0)
        .then((_) => print('Save current result to localStorage.'))
        .catchError((error) => print(error));
    return roundResult;
  }

  String _nodeString() {
    String message = '';
    for (var node in _countriesChain) message += '${node.toString()}.\n';
    return message;
  }

//  @override
//  String toString() =>
//      'There are total ${this._countriesChain.length} nodes. \n> Question ${question.toString()} \n> Answer ${answers.toString()}\n';
  @override
  String toString() {
    return 'Node cursor at ${_countriesChain[_hardCursor].testCursor()}.\nCursor at node $_easyCursor. ${_nodeString()}.';
  }
}
