import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/Question.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flutter/foundation.dart';
import 'package:flaguru/models/Enum.dart';

class RoundHandler {
  Difficulty _level = Difficulty.EASY;
  var _localStorage = LocalStorage();

  // Life props
  final lifeTotal;
  int _remainLives;

  int get remainLives {
    return this._remainLives;
  }

  set _setRemainLife(int newLife) {
    this._remainLives = newLife;
    if (this._remainLives == 0) {
      this._status = RoundStatus.OVER;
    }
  }

  // Time props
  final timeLimit;

  // Question props
  final numOfQtn;
  int _remainQuestions;

  int get remainQuestions {
    return this._remainQuestions;
  }

  set _setRemainQuestions(int value) {
    this._remainQuestions = value;
    if (this._remainQuestions == 0) {
      this._status = RoundStatus.OVER;
    }
  }

  // Round starting status
  RoundStatus _status;

  RoundStatus get status {
    return this._status;
  }

  Result get result {
    if (this._status != RoundStatus.OVER) return null;
    var roundResult = Result(
        level: this._level,
        totalTimeElapsed: this._totalTimeElapsed,
        totalTimeLeftRightAnswers: this._totalTimeLeftRightAnswers,
        correctAnswers: this._correctAnswersCounter,
        questionsCounter: this.numOfQtn,
        remainLives: this.remainLives,
        totalLives: this.lifeTotal,
        answerLogs: this._logs);
    this
        ._localStorage
        .saveResult(roundResult.score, this._level, this.remainLives > 0)
        .then((_) => print('save current result to localStorage'))
        .catchError((error) => print(error));
    return roundResult;
  }

  int _totalTimeElapsed = 0;
  int _totalTimeLeftRightAnswers = 0;
  int _correctAnswersCounter = 0;
  var _answerLogs = List<AnswerLog>();

  List<AnswerLog> get _logs {
    return this._answerLogs;
  }

  set _setLogs(AnswerLog log) {
    this._answerLogs.add(log);
  }

  RoundHandler({
    @required Difficulty level,
    @required this.lifeTotal,
    @required this.numOfQtn,
    @required this.timeLimit,
  }) {
    if (lifeTotal < 1) throw Exception("Life count per round should be greater than 0");
    if (timeLimit < 1) throw Exception("countdown time should be at least 1");
    if (numOfQtn < 1) throw Exception("There should be at least one question");
    this._level = level;
    this._remainLives = lifeTotal;
    this._remainQuestions = numOfQtn;
    this._status = RoundStatus.IDLE;
  }

  void getAnswer(
      {@required bool isCorrect,
      @required Question question,
      @required int timeLeft,
      Answer answer}) {
    if (this.status != RoundStatus.PLAYING)
      throw Exception("Round status is yet started or is over");
    if (this.timeLimit < timeLeft)
      throw Exception("Why would countdown remain greater than countdown time?");

    final timeElapsed = timeLimit - timeLeft;

    this._totalTimeElapsed += timeElapsed;
    this._setRemainQuestions = this.remainQuestions - 1;

    if (isCorrect) {
      this._correctAnswersCounter += 1;
      this._totalTimeLeftRightAnswers += timeLeft;
    } else {
      this._setRemainLife = this.remainLives - 1;
    }

    this._setLogs = AnswerLog(question, answer, isCorrect, timeElapsed);
  }

  void reset() {
    this._status = RoundStatus.IDLE;
    this._setRemainLife = lifeTotal;
    this._setRemainQuestions = numOfQtn;
  }

  bool start() {
    if (this._status == RoundStatus.IDLE) {
      // round is start
      this._status = RoundStatus.PLAYING;
      this
          ._localStorage
          .newRound(this._level)
          .then((_) => print('New round is started'))
          .catchError((error) => print(error));
      return true;
    }
    return false;
  }
}
