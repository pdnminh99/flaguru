 import 'package:flaguru/models/Answer.dart';

 const List<Map<String, Object>> DUMMY_QA = [
   {
     'question': QuestionUI(
       country: 'USA',
       imageURL: 'assets/images/flag-of-United-States-of-America.png',
     ),
     'answer': [
       Answer(
         country: 'Vietnam',
         imageUrl: 'assets/images/flag-of-Afghanistan.png',
         isRight: false,
       ),
       Answer(
         country: 'United States of America',
         imageUrl: 'assets/images/flag-of-United-States-of-America.png',
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
       imageURL: 'assets/images/flag-of-Vietnam.png',
     ),
     'answer': [
       Answer(
         country: 'Vietnam',
         imageUrl: 'assets/images/flag-of-Vietnam.png',
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
       imageURL: 'assets/images/flag-of-Japan.png',
     ),
     'answer': [
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
         country: 'China',
         imageUrl: 'assets/images/flag-of-Algeria.png',
         isRight: false,
       ),
       Answer(
         country: 'Japan',
         imageUrl: 'assets/images/flag-of-Japan.png',
         isRight: true,
       ),
     ],
   },
   {
     'question': QuestionUI(
       country: 'China',
       imageURL: 'assets/images/flag-of-China.png',
     ),
     'answer': [
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
         country: 'China',
         imageUrl: 'assets/images/flag-of-China.png',
         isRight: true,
       ),
       Answer(
         country: 'Japan',
         imageUrl: 'assets/images/flag-of-Japan.png',
         isRight: false,
       ),
     ],
   }
 ];
