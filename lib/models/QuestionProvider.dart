import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/Question.dart';

class QuestionProvider {
  var _collections = List<Question>();

  initializeQuestions({Difficulty level: Difficulty.EASY}) async {
    var db = DatabaseConnector();
    var countries = await db.collectCountries(count: 100);
    for (var i = 0; i < 100; i++) {
      
    }
  }

  List<Question> getCollections() => this._collections;
}
