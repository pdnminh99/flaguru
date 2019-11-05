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
  bool _isLivesCountON;

  int get remainLives => this._remainLives;

  set _setRemainLives(int livesCount) {
    if (livesCount < 0) throw Exception('Why would lives count negative?');
    if (!this._isLivesCountON)
      throw Exception(
          'You cannot set lives count in a non-livesCount gameplay.');
    this._remainLives = livesCount;
  }

  bool get isAlive => this._remainLives > 0;

  // Question props
  int _questions = 1;

  int get passedQuestions => this._questions;

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

  static bool isInit() => _handlerInstance != null;

  RoundHandler._internal();

  static RoundHandler _handlerInstance;

  static Future<RoundHandler> getInstance(
      {Difficulty level: Difficulty.EASY,
      int lifeCount: 5,
      int timeLimit: 15,
      bool isLivesCountON: true,
      bool isFirstAnswerAlwaysRight: false}) async {
    if (_handlerInstance == null) {
      // Handle exceptions.
      if (lifeCount < 1 && isLivesCountON)
        throw Exception("Life count per round should be greater than 0");
      if (timeLimit < 1) throw Exception("countdown time should be at least 1");
      if (level == Difficulty.UNLIMITED && !isLivesCountON)
        throw Exception('Unlimited gameplay must include lives Counter');
      print('Found no instance of RoundHandler, initialize new one');
      _handlerInstance = RoundHandler._internal();
      // initialize default params.
      await _handlerInstance._initializeDefaultParams(
          level, lifeCount, isLivesCountON, isFirstAnswerAlwaysRight);
    } else {
      print('Found an instance of RoundHandler.');
      // In case where user choose a new difficulty.
      _handlerInstance._initializeStaticParams(
          level, lifeCount, isLivesCountON, isFirstAnswerAlwaysRight);
    }
    // print(_handlerInstance._countriesChain.toString());
    return _handlerInstance;
  }

  void _initializeStaticParams(
    Difficulty level,
    int lifeCount,
    bool isLivesCountON,
    bool isFirstAnswerAlwaysRight,
  ) {
    this._level = level;
    this._lifeCount = isLivesCountON ? lifeCount : -1;
    this._remainLives = isLivesCountON ? lifeCount : -1;
    this._isLivesCountON = isLivesCountON;
    this._questions = 1;
    this.generateQAs(
      isFirstAnswerAlwaysRight: isFirstAnswerAlwaysRight,
    );
    this._easyCursor = 0;
    this._normalCursor = this._lastIndex ~/ 2;
    this._hardCursor = this._lastIndex;
  }

  Future<void> _initializeDefaultParams(
    Difficulty level,
    int lifeCount,
    bool isLivesCountON,
    bool isFirstAnswerAlwaysRight,
  ) async {
    this._initializeStaticParams(
        level, lifeCount, isLivesCountON, isFirstAnswerAlwaysRight);
    // collect countries and parse to chain.
    var database = DatabaseConnector();
    (await database.collectCountries()).forEach((country) {
      // print(country.toString());
      // if (country.ratio != 100)
      //   print('> ${country.name} has ratio ${country.ratio}\n');
      if (this._countriesChain.length == 0 ||
          this._countriesChain[this._lastIndex].ratio != country.ratio)
        this._createNode(country);
      else
        this._countriesChain[this._lastIndex].insert(country);
    });
  }

  void _createNode(Country newCountry) {
    this._countriesChain.add(Node(newCountry));
    this._hardCursor = this._lastIndex;
    this._normalCursor = this._lastIndex ~/ 2;
  }

  void generateQAs(
      {bool isFirstAnswerAlwaysRight: false, int answerCounter: 4}) {
    /*
     * If questions count equal or greater than its maximum, game over. 
     */
    this._questions += 1;
    this.answers.clear();
    for (int counter = 0; counter < answerCounter; counter++)
      this.answers.add(this
          ._countriesChain[this._rand.nextInt(this._countriesChain.length)]
          .getRandomAnswer());
    switch (this._level) {
      case Difficulty.UNLIMITED:
      case Difficulty.EASY:
        while (this._countriesChain[this._easyCursor].getQuestion() == null) {
          this._easyCursor++;
          if (this._easyCursor > this._lastIndex) this._easyCursor = 0;
        }
        this.question = this._countriesChain[this._easyCursor].getQuestion();
        break;
      case Difficulty.NORMAL:
      case Difficulty.HARD:
        while (this._countriesChain[this._hardCursor].getQuestion() == null) {
          this._hardCursor--;
          if (this._hardCursor < 0) this._hardCursor = this._lastIndex;
        }
        this.question = this._countriesChain[this._hardCursor].getQuestion();
        break;
      default:
        throw Exception('Unknown difficulty');
    }
    if (isFirstAnswerAlwaysRight)
      this.answers[0] = question.toAnswer();
    else
      this.answers[this._rand.nextInt(5)] = question.toAnswer();
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
    } else if (this._isLivesCountON)
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

  @override
  String toString() {
    String message = 'There are total ${this._countriesChain.length} nodes.\n';
    int counter = 0;
    this._countriesChain.forEach((node) {
      message += '$counter) ${node.toString()}';
    });
    return message;
  }
}
