import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flutter/cupertino.dart';

class Question {
  int questionID;
  var answers = List<Country>();
  int time;
  Country _correctAnswer;

  Question({@required int initID, @required Country country, time = 5000}) {
    this.questionID = initID;
    this.time = time;
    this._correctAnswer = country;
  }

  Future<void> initializeQuestion() async {
    var sqlConnector = DatabaseConnector();
    var countries = await sqlConnector.collectCountries(count: 3);
    for (var country in countries) this.answers.add(country);
    this.answers.add(this._correctAnswer);
  }

  bool verifyAnswer({ Country countryAnswer, int indexAnswer }) {
    if (this.answers.length == 1) throw "You must call [Question instance].initializeQuestion(initID, country, time); first";

  }
}
