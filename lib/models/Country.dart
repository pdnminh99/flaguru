import 'Answer.dart';
import 'Question.dart';

class Country {
  String id;
  String name;
  String flag;
  String continent;

  Country({String id, String name, String flag, String continent}) {
    this.id = id != null ? id : '';
    this.name = name;
    this.flag = flag;
    this.continent = continent;
  }

  Answer toAnswer({isCorrect: false}) {
    return Answer(country: this.name, imageUrl: this.flag, isRight: isCorrect);
  }

  Question toQuestion() {
    return Question(this);
  }

}
