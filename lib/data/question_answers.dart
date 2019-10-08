import 'package:flaguru/models/Answer.dart';

const List<Map<String, Object>> DUMMY_QA = [
  {
    'question': QuestionUI(
      country: 'America',
      imageUrl: 'assets/images/flag-of-Algeria.png',
    ),
    'answers': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
      ),
      Answer(
        country: 'America',
        imageUrl: 'assets/images/flag-of-Algeria.png',
        isRight: true,
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-El-Salvador.png',
        isRight: false,
      ),
    ],
  },
  {
    'question': QuestionUI(
      country: 'Vietnam',
      imageUrl: 'assets/images/flag-of-Afghanistan.png',
    ),
    'answers': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Algeria.png',
        isRight: true,
      ),
      Answer(
        country: 'America',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-El-Salvador.png',
        isRight: false,
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
      ),
    ],
  },
  {
    'question': QuestionUI(
      country: 'Japan',
      imageUrl: 'assets/images/flag-of-El-Salvador.png',
    ),
    'answers': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
      ),
      Answer(
        country: 'America',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-Algeria.png',
        isRight: false,
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-El-Salvador.png',
        isRight: true,
      ),
    ],
  }
];
