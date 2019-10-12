import 'package:flutter/foundation.dart';

class Answer {
  final String imageUrl;
  final String country;
  final bool isRight;

  const Answer({
    @required this.country,
    @required this.imageUrl,
    @required this.isRight,
  });

  @override
  String toString() {
    return 'name: ${this.country}; flagURL: ${this.imageUrl}; isRight: ${this.isRight}';
  }
}

class QuestionUI {
  final String imageUrl;
  final String country;

  const QuestionUI({
    @required this.country,
    @required this.imageUrl,
  });
}
