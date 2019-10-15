import 'package:flutter/foundation.dart';

class Answer {
  final String imageUrl;
  final String country;
  final bool isRight;
  final double ratio;
  final String description;

  const Answer({
    @required this.country,
    @required this.imageUrl,
    @required this.isRight,
    @required this.ratio,
    @required this.description,
  });

  @override
  String toString() {
    return '${this.country}, isRight: ${this.isRight}, description ${this.description}';
  }
}

class QuestionUI {
  final String imageURL;
  final String country;

  const QuestionUI({
    @required this.country,
    @required this.imageURL,
  });
}
