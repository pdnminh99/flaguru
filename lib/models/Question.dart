import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Enum.dart';

class Question {
  int countryID;
  String country;
  String imageURL;
  String description;
  Continent continent;
  // int node;

  @override
  String toString() {
    return '$countryID: $country\n';
  }

  Question(Country country) {
    this.countryID = country.id;
    this.country = country.name;
    this.imageURL = country.flag;
    this.description = country.description;
    // this.node = country.nodeAddress;
    this.continent = country.continent;
  }

  Answer toAnswer() => Answer(
      country: country,
      countryID: countryID,
      imageUrl: imageURL,
      description: description);
}
