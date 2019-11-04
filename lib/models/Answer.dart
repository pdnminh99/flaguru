import 'package:flutter/foundation.dart';

class Answer {
  final int countryID;
  final String imageUrl;
  final String country;
  final bool isRight;
  final String description;

  const Answer({
    @required this.countryID,
    @required this.country,
    @required this.imageUrl,
    @required this.isRight,
    @required this.description,
  });

  @override
  String toString() {
    return '$countryID; name $country\n';
  }
}

//class QuestionUI {
//  final String imageURL;
//  final String country;
//  final String description;
//
//  const QuestionUI({
//    @required this.country,
//    @required this.imageURL,
//    @required this.description,
//  });
//}
