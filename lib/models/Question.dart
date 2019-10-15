import 'package:flaguru/models/Country.dart';

class Question {
  String country;
  String imageURL;
  double ratio;
  String description;
  // int questionID;
  // var answers = List<Country>();
  // int time;
  // Country _correctAnswer;

  @override
  String toString() {
    return 'name: ${this.country}; flagURL: ${this.imageURL}; ratio: ${this.ratio} and description: ${this.description}';
  }

  Question(Country country) {
    this.country = country.name;
    this.imageURL = country.flag;
    this.ratio = country.ratio;
    this.description = country.description;
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
