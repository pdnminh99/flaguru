import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Question.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flutter/foundation.dart';
import 'package:flaguru/models/Enum.dart';

class RoundHandler {
  Difficulty _level = Difficulty.EASY;

  // Life props
  int _lifeCount = 0;
  int _remainLives = 0;

  int get remainLives {
    return this._remainLives;
  }

  set _setRemainLife(int newlife) {
    this._remainLives = newlife;
    if (this._remainLives == 0) {
      this._status = RoundStatus.OVER;
    }
  }

  // Time props
  int _countdown = 0;

  // Question props
  int _questions = 0;
  int _remainQuestions = 0;

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
    return new Result(
        level: this._level,
        totalTime: this._roundTimer,
        correctAnswers: this._correctAnswersCounter,
        questionsCounter: this._questions,
        remainLives: this.remainLives,
        totalLives: this._lifeCount,
        answerLogs: this._logs);
  }

  int _roundTimer = 0;
  int _correctAnswersCounter = 0;
  var _answerLogs = List<AnswerLog>();

  List<AnswerLog> get _logs {
    return this._answerLogs;
  }

  set _setLogs(AnswerLog log) {
    this._answerLogs.add(log);
    this._roundTimer += log.answerTime;
  }

  RoundHandler({
    @required Difficulty level,
    @required int lifecount,
    @required int questions,
    @required int countdown,
  }) {
    if (lifecount < 1)
      throw Exception("Life count per round should be greater than 0");
    if (countdown < 1) throw Exception("countdown time should be at least 1");
    if (questions < 1) throw Exception("There should be at least one question");
    this._level = level;
    this._lifeCount = lifecount;
    this._remainLives = lifecount;
    this._questions = questions;
    this._remainQuestions = questions;
    this._countdown = countdown;
    this._status = RoundStatus.IDLE;
  }

  void getAnswer(
      {@required bool isCorrect,
      @required Question question,
      @required int countdownRemain,
      Answer answer}) {
    if (this.status != RoundStatus.PLAYING)
      throw Exception("Round status is yet started or is over");
    if (this._countdown < countdownRemain)
      throw Exception(
          "Why would countdown remain greater than countdown time?");
    if (isCorrect) {
      this._setRemainQuestions = this.remainQuestions - 1;
      this._correctAnswersCounter += 1;
    } else {
      this._setRemainLife = this.remainLives - 1;
      this._setRemainQuestions = this.remainQuestions - 1;
    }
    this._setLogs = AnswerLog(
      question,
      answer,
      isCorrect,
      isCorrect ? this._countdown - countdownRemain : 0,
    );
  }

  void reset() {
    this._status = RoundStatus.IDLE;
    this._setRemainLife = this._lifeCount;
    this._setRemainQuestions = this._questions;
  }

  bool start() {
    if (this._status == RoundStatus.IDLE) {
      // round is start
      this._status = RoundStatus.PLAYING;
      return true;
    }
    return false;
  }
}
