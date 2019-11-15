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

  int get lifeCount => _lifeCount;

  int remainLives = 0;

  bool get isAlive => remainLives > 0;

  // Question props
  int _questions = 0;

  int get passedQuestions => _questions;

  // Answers props
  int _correctAnswersCounter = 0;
  var _answerLogs = List<AnswerLog>();

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

  static Future<RoundHandler> getInstance(
      {Difficulty level: Difficulty.EASY,
      int lifeCount: 1,
      int timeLimit: 15,
      bool isFirstAnswerAlwaysRight: false}) async {
    // Handle exceptions.
    if (lifeCount < 1) throw Exception("Life count per round should be greater than 0");
    if (timeLimit < 1) throw Exception("countdown time should be at least 1");
    var _handlerInstance = RoundHandler();
    // initialize default params.
    await _handlerInstance._initializeDefaultParams(
        level, lifeCount, timeLimit, isFirstAnswerAlwaysRight);
    // print(_handlerInstance._countriesChain.toString());
    return _handlerInstance;
  }

  void _initializeStaticParams(
    Difficulty level,
    int lifeCount,
    int timeLimit,
    bool isFirstAnswerAlwaysRight,
  ) {
    // clear old answer logs.
    _answerLogs.clear();
    // get new variables.
    _level = level;
    _lifeCount = lifeCount;
    remainLives = lifeCount;
    _questions = 0;
    _isFirstAnswerAlwaysRight = isFirstAnswerAlwaysRight;
    _timeLimit = timeLimit;
    // reset cursor.
    _easyCursor = _lastIndex;
    _normalCursor = _lastIndex ~/ 2;
    _isNormalCursorHeadLeft = true;
    _distanceFromNormalCursor = 0;
    _hardCursor = 0;
  }

  Future<void> _initializeDefaultParams(
    Difficulty level,
    int lifeCount,
    int timeLimit,
    bool isFirstAnswerAlwaysRight,
  ) async {
    _initializeStaticParams(level, lifeCount, timeLimit, isFirstAnswerAlwaysRight);
    // collect countries and parse to chain.
    _sqlDatabase = await DatabaseConnector.getInstance();
    (await _sqlDatabase.collectCountries()).forEach((country) {
      if (_countriesChain.length == 0 || _countriesChain[_lastIndex].ratio != country.ratio)
        _createNode(country);
      else
        _countriesChain[_lastIndex].insert(country);
    });
    generateQAs();
  }

  void _createNode(Country newCountry) {
    _countriesChain.add(Node(newCountry));
    _easyCursor = _lastIndex;
    _normalCursor = _lastIndex ~/ 2;
  }

  void generateQAs() {
    if (remainLives <= 0) throw Exception('There is no lives remain to generate new question.');
    _generateAnswers(4);
    switch (_level) {
      case Difficulty.ENDLESS:
      case Difficulty.EASY:
        _generateEasyQuestion();
        break;
      case Difficulty.NORMAL:
        _generateNormalQuestion();
        break;
      case Difficulty.HARD:
        _generateHardQuestion();
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

  void _generateAnswers(int numberOfAnswers) {
    _questions += 1;
    answers.clear();
    for (int counter = 0; counter < numberOfAnswers; counter++) {
      var isDupicate = false;
      Answer nominationAnswer;
      do {
        isDupicate = false;
        nominationAnswer = _countriesChain[_rand.nextInt(_countriesChain.length)].getRandomAnswer();
        for (var answer in answers)
          if (answer.countryID == nominationAnswer.countryID) isDupicate = true;
      } while (isDupicate);
      answers.add(nominationAnswer);
    }
  }

  void _generateEasyQuestion() {
    do {
      question = _countriesChain[_easyCursor].getQuestion();
      if (question == null) _easyCursor--;
      if (_easyCursor < 0) _easyCursor = _lastIndex;
    } while (question == null);
  }

  void _generateNormalQuestion() {
    do {
      var leftCursor = _normalCursor - _distanceFromNormalCursor;
      var rightCursor = _normalCursor + _distanceFromNormalCursor;
      // case both side is out of range.
      if (leftCursor < 0 && rightCursor > _lastIndex) {
        _isNormalCursorHeadLeft = true;
        _distanceFromNormalCursor = 0;
      }
      // case heading left.
      if (_isNormalCursorHeadLeft)
        _fetchLeftFromNormalCursor(leftCursor);
      // case heading right.
      else
        _fetchRightFromNormalCursor(rightCursor);
    } while (question == null);
  }

  void _fetchLeftFromNormalCursor(int leftCursor) {
    // if left side is still in range.
    question = leftCursor >= 0 ? _countriesChain[leftCursor].getQuestion() : null;
    _isNormalCursorHeadLeft = question != null;
  }

  void _fetchRightFromNormalCursor(int rightCursor) {
    // if right side is still in range.
    if (rightCursor <= _lastIndex) {
      question = _countriesChain[rightCursor].getQuestion();
      if (question == null) {
        _isNormalCursorHeadLeft = true;
        _distanceFromNormalCursor++;
      }
    } else {
      question = null;
      _distanceFromNormalCursor++;
    }
  }

  void _generateHardQuestion() {
    do {
      question = _countriesChain[_hardCursor].getQuestion();
      if (question == null) _hardCursor++;
      if (_hardCursor >= _countriesChain.length) _hardCursor = 0;
    } while (question == null);
  }

  bool verifyAnswer({@required int timeLeft, @required Answer answer}) {
    if (this._timeLimit < timeLeft)
      throw Exception("Why would countdown remain greater than countdown time?");
    final timeElapsed = _timeLimit - timeLeft;
    this._totalTimeElapsed += timeElapsed;
    bool isCorrect;
    if (answer == null) {
      isCorrect = false;
      if (_isVerified) return isCorrect;
      remainLives -= 1;
    } else {
      isCorrect = answer.countryID == question.countryID;
      // prevent FE from verifying one question more than once.
      if (_isVerified) return isCorrect;
      if (isCorrect) {
        _correctAnswersCounter += 1;
        _totalTimeLeftRightAnswers += timeLeft;
      } else
        remainLives -= 1;
    }
    var newLog = AnswerLog(question, answer, isCorrect, timeElapsed);
    _answerLogs.add(newLog);
    // add Log to database.
    _sqlDatabase.addLog(newLog);
    _isVerified = true;
    return isCorrect;
  }

  void start() {
    LocalStorage.newRound(_level)
        .then((_) => print('New round is started'))
        .catchError((error) => print(error));
  }

  Result getResult() {
    var roundResult = Result(
        level: _level,
        totalTimeElapsed: _totalTimeElapsed,
        totalTimeLeftRightAnswers: _totalTimeLeftRightAnswers,
        correctAnswers: _correctAnswersCounter,
        questionsCounter: passedQuestions,
        remainLives: remainLives,
        totalLives: _lifeCount,
        answerLogs: _answerLogs);
    // TODO check if network connection available before saveLog.
    _sqlDatabase.saveLogs();
    LocalStorage.saveResult(roundResult.score, _level, remainLives > 0)
        .then((_) => print('Saved current result to localStorage.'))
        .catchError((error) => print(error));
    return roundResult;
  }

  String _nodeString() {
    String message = '';
    for (var node in _countriesChain) message += '${node.toString()}.\n';
    return message;
  }

  @override
  String toString() => '''
      *** Node cursor at ${_countriesChain[_normalCursor].testCursor()}. ***
      *** Cursor at node ${_countriesChain[_normalCursor].ratio}. ***
${_nodeString()}
''';
}
