import 'package:flaguru/models/Answer.dart';

const List<Map<String, Object>> DUMMY_QA = [
  {
    'question': QuestionUI(
      country: 'United States of America',
      imageURL: 'assets/images/flag-of-United-States-of-America.png',
      description:
          'Vietnam officially the Socialist Republic of Vietnam is the easternmost country on the Indochina Peninsula. With an estimated 94.6 million inhabitants as of 2016, it is the 15th most populous country in the world. Vietnam shares its land borders with China to the north.',
    ),
    'answer': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
        description: '',
        ratio: 1,
      ),
      Answer(
        country: 'United States of America',
        imageUrl: 'assets/images/flag-of-United-States-of-America.png',
        isRight: true,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-El-Salvador.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
    ],
  },
  {
    'question': QuestionUI(
      country: 'Vietnam',
      imageURL: 'assets/images/flag-of-Vietnam.png',
      description:
          'Vietnam officially the Socialist Republic of Vietnam is the easternmost country on the Indochina Peninsula. With an estimated 94.6 million inhabitants as of 2016, it is the 15th most populous country in the world. Vietnam shares its land borders with China to the north.',
    ),
    'answer': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Vietnam.png',
        isRight: true,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'United States of America',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-El-Salvador.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
    ],
  },
  {
    'question': QuestionUI(
      country: 'Japaa aaan Vietnam',
      imageURL: 'assets/images/flag-of-Japan.png',
      description:
          'Vietnam officially the Socialist Republic of Vietnam is the easternmost country on the Indochina Peninsula. With an estimated 94.6 million inhabitants as of 2016, it is the 15th most populous country in the world. Vietnam shares its land borders with China to the north.',
    ),
    'answer': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'America',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-Algeria.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-Japan.png',
        isRight: true,
        ratio: 1,
        description: '',
      ),
    ],
  },
  {
    'question': QuestionUI(
      country: 'China',
      imageURL: 'assets/images/flag-of-China.png',
      description:
          'Vietnam officially the Socialist Republic of Vietnam is the easternmost country on the Indochina Peninsula. With an estimated 94.6 million inhabitants as of 2016, it is the 15th most populous country in the world. Vietnam shares its land borders with China to the north.',
    ),
    'answer': [
      Answer(
        country: 'Vietnam',
        imageUrl: 'assets/images/flag-of-Afghanistan.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'United States of America',
        imageUrl: 'assets/images/flag-of-Argentina.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'China',
        imageUrl: 'assets/images/flag-of-China.png',
        isRight: true,
        ratio: 1,
        description: '',
      ),
      Answer(
        country: 'Japan',
        imageUrl: 'assets/images/flag-of-Japan.png',
        isRight: false,
        ratio: 1,
        description: '',
      ),
    ],
  }
];
