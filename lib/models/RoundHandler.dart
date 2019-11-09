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
  Difficulty _level;

  // Life props
  int _lifeCount = 0;
  int _remainLives = 0;

  int get remainLives => _remainLives;

  set _setRemainLives(int livesCount) {
    if (livesCount < 0) throw Exception('Why would lives count negative?');
    _remainLives = livesCount;
  }

  bool get isAlive => _remainLives > 0;

  // Question props
  int _questions = 0;

  int get passedQuestions => _questions;

  // Answers props
  int _correctAnswersCounter = 0;
  var _answerLogs = List<AnswerLog>();

  List<AnswerLog> get _logs => this._answerLogs;

  set _setLogs(AnswerLog log) => this._answerLogs.add(log);

  // Timing props
  int _totalTimeElapsed = 0;
  int _totalTimeLeftRightAnswers = 0;
  int _timeLimit;

  // Questions props
  var _countriesChain = List<Node>();

  var answers = List<Answer>();
  Question question;

  int get _lastIndex => this._countriesChain.length - 1;

  int _easyCursor;
  int _hardCursor;
  int _normalCursor;

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
    this._level = level;
    this._lifeCount = lifeCount;
    this._remainLives = lifeCount;
    this._questions = 0;
    this._isFirstAnswerAlwaysRight = isFirstAnswerAlwaysRight;
    this._easyCursor = _lastIndex;
    this._normalCursor = this._lastIndex ~/ 2;
    this._hardCursor = 0;
  }

  Future<void> _initializeDefaultParams(
    Difficulty level,
    int lifeCount,
    bool isFirstAnswerAlwaysRight,
  ) async {
    _initializeStaticParams(level, lifeCount, isFirstAnswerAlwaysRight);
    // collect countries and parse to chain.
    var database = DatabaseConnector();
    (await database.collectCountries()).forEach((country) {
      // print(country.toString());
      // if (country.ratio != 100)
      //   print('> ${country.name} has ratio ${country.ratio}\n');
      if (_countriesChain.length == 0 ||
          _countriesChain[_lastIndex].ratio != country.ratio)
        _createNode(country);
      else
        _countriesChain[_lastIndex].insert(country);
    });
    generateQAs(
        // isFirstAnswerAlwaysRight: isFirstAnswerAlwaysRight,
        );
  }

  void _createNode(Country newCountry) {
    _countriesChain.add(Node(newCountry));
    _easyCursor = _lastIndex;
    _normalCursor = _lastIndex ~/ 2;
  }

  void generateQAs() {
    if (remainLives < 0)
      throw Exception('There is no lives remain to generate new question.');
    _questions += 1;
    answers.clear();
    for (int counter = 0; counter < 4; counter++)
      answers.add(_countriesChain[_rand.nextInt(_countriesChain.length)]
          .getRandomAnswer());
    switch (_level) {
      case Difficulty.UNLIMITED:
      case Difficulty.EASY:
        // while (_countriesChain[_easyCursor].getQuestion() == null) {
        //   _easyCursor--;
        //   if (_easyCursor < 0) _easyCursor = 0;
        // }
        // question = _countriesChain[_easyCursor].getQuestion();
        do {
          question = _countriesChain[_easyCursor].getQuestion();
          if (question == null) _easyCursor--;
          if (_easyCursor < 0) _easyCursor = _lastIndex;
        } while (question == null);
        break;
      case Difficulty.NORMAL:
      case Difficulty.HARD:
        while (_countriesChain[_hardCursor].getQuestion() == null) {
          _hardCursor--;
          if (_hardCursor < 0) _hardCursor = _lastIndex;
        }
        question = _countriesChain[_hardCursor].getQuestion();
        break;
      default:
        throw Exception('Unknown difficulty');
    }
    if (_isFirstAnswerAlwaysRight)
      answers[0] = question.toAnswer();
    else
      answers[_rand.nextInt(answers.length)] = question.toAnswer();
  }

  bool verifyAnswer({@required int timeLeft, @required Answer answer}) {
    if (this._timeLimit < timeLeft)
      throw Exception(
          "Why would countdown remain greater than countdown time?");
    final timeElapsed = _timeLimit - timeLeft;
    this._totalTimeElapsed += timeElapsed;
    var isCorrect = answer.countryID == this.question.countryID;
    if (isCorrect) {
      this._correctAnswersCounter += 1;
      this._totalTimeLeftRightAnswers += timeLeft;
    } else
      this._setRemainLives = this.remainLives - 1;
    this._setLogs = AnswerLog(this.question, answer, isCorrect, timeElapsed);
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
        answerLogs: this._logs);
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
    return 'Cursor at node $_easyCursor. ${_nodeString()} node cursor at ${_countriesChain[_easyCursor].testCursor()}.';
  }
}
