import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Country.dart';

class Question {
  int countryID;
  String country;
  String imageURL;
  String description;
  int node;

  @override
  String toString() {
    return '$countryID: $country\n';
  }

  Question(Country country) {
    this.countryID = country.id;
    this.country = country.name;
    this.imageURL = country.flag;
    this.description = country.description;
    this.node = country.nodeAddress;
  }

  Answer toAnswer() => Answer(
      country: country,
      countryID: countryID,
      imageUrl: imageURL,
      description: description);
}
