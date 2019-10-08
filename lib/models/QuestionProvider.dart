import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Enum.dart';

import 'Answer.dart';
import 'Country.dart';
import 'Question.dart';

class QuestionProvider {
  Difficulty level;
  var _countries = List<Country>();

  QuestionProvider({Difficulty level: Difficulty.EASY}) {
    this.level = level;
  }

  Future<void> initializeQuestionsProvider() async {
    var database = DatabaseConnector();
    this._countries = await database.collectCountries();
  }

  List<Map<String, Object>> getCollections() {
    var collections = List<Map<String, Object>>();
    for (var country in this._countries) {
      collections.add(this._parseQA(country));
    }
    return collections;
  }

  List<Answer> _getAnswerCollections(Country country) {
    var candidates = List<Answer>();
    for (var i = 0; i < 3; i++) {
      candidates.add(this._countries[i].toAnswer());
    }
    return candidates;
  }

  Map<String, Object> _parseQA(Country country) {
    return {
      'question': Question(country),
      'answer': [
        country.toAnswer(isCorrect: true),
        ..._getAnswerCollections(country)
      ]
    };
  }

}
