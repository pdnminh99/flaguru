import 'package:flaguru/models/Country.dart';

class Question {
  String country;
  String imageURL;
  // int questionID;
  // var answers = List<Country>();
  // int time;
  // Country _correctAnswer;

  @override
  String toString() {
    return 'name: ${this.country}; flagURL: ${this.imageURL}';
  }

  Question(Country country) {
    this.country = country.name;
    this.imageURL = country.flag;
    // this.questionID = initID;
    // this.time = time;
    // this._correctAnswer = country;
  }
}
// Future<void> initializeQuestion() async {
//   var sqlConnector = DatabaseConnector();
//   var countries = await sqlConnector.collectCountries(count: 3);
//   for (var country in countries) this.answers.add(country);
//   this.answers.add(this._correctAnswer);
// }

// bool verifyAnswer({ Country countryAnswer, int indexAnswer }) {
//   if (this.answers.length == 1) throw "You must call [Question instance].initializeQuestion(initID, country, time); first";

// }
