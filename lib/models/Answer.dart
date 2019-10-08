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
}

class QuestionUI {
  final String imageUrl;
  final String country;

  const QuestionUI ({
    @required this.country,
    @required this.imageUrl,
  });
}

Map<String, Object> questionAnswers = {
  'question': QuestionUI(
    country: 'America',
    imageUrl: 'assets/images/flag2.png',
  ),
  'answers': [
    Answer(
      country: 'Vietnam',
      imageUrl: 'assets/images/flag1.png',
      isRight: false,
    ),
    Answer(
      country: 'America',
      imageUrl: 'assets/images/flag2.png',
      isRight: true,
    ),
    Answer(
      country: 'Japan',
      imageUrl: 'assets/images/flag3.png',
      isRight: false,
    ),
    Answer(
      country: 'China',
      imageUrl: 'assets/images/flag4.png',
      isRight: false,
    ),
  ],
};
