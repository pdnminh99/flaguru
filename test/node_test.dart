import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // found that if chances equals 0 -> cause many errors.
  var dummyData = [
    Country(
      id: 1,
      name: 'Vietnam',
      chances: 0,
    ),
    Country(
      id: 2,
      name: 'America',
      chances: 0,
    ),
    Country(
      id: 3,
      name: 'Japan',
      chances: 0,
    ),
    Country(
      id: 4,
      name: 'Deutch',
      chances: 0,
    ),
    Country(
      id: 5,
      name: 'German',
      chances: 0,
    ),
    Country(
      id: 6,
      name: 'Laos',
      chances: 0,
    ),
    Country(
      id: 7,
      name: 'Singapore',
      chances: 0,
    ),
    Country(
      id: 8,
      name: 'Malaysia',
      chances: 0,
    ),
  ];
  var falseCountry = Country(id: 10, name: 'Wakanda', chances: 0);
  group('Initializing test.', () {
    test('New node is not null.', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode, isNotNull);
    });
    test('There should be at least 1 country', () {
      var sampleNode = Node(dummyData[0]);
      var countries = sampleNode.testCountries();
      expect(countries.length, equals(1));
    });
    test('First country should be Vietnam', () {
      var sampleNode = Node(dummyData[0]);
      var countries = sampleNode.testCountries();
      expect(countries[0], equals(dummyData[0]));
    });
    test('Ratio should be equal Vietnam', () {
      var sampleNode = Node(dummyData[0]);
      var ratio = sampleNode.testRatio();
      expect(ratio, equals(dummyData[0].ratio));
    });
    test('Startup cursor should be at 0', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode.testCursor(), equals(0));
    });
    test('isEmpty method works', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode.isEmpty(), isFalse);
    });

    /*
     * Why print statement print out 0 chance but test statement is not.
     */

    test('First country chances should be 0.', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode.testCountries()[0].chances, equals(0));
    });
  });

  group('First time get question.', () {
    test('insert func success.', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode.insert(dummyData[1]), isTrue);
    });
    test('Node length should be 2 after insert', () {
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      expect(sampleNode.testCountries().length, equals(2));
    });
    test('Inserted country should be America.', () {
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      expect(sampleNode.testCountries()[1], equals(dummyData[1]));
    });
    test('Inserting country with different ratio should raise a false.', () {
      var sampleNode = Node(dummyData[0]);
      expect(sampleNode.insert(falseCountry), isFalse);
    });
    test('The false country is not inserted.', () {
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(falseCountry);
      expect(sampleNode.testCountries().length, equals(1));
      expect(sampleNode.testCountries()[0], equals(dummyData[0]));
    });
    test('Return question should not be null', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      expect(question, isNotNull);
    });
    test('Question should be Vietnam', () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      var question = sampleNode.getQuestion();
      // assertion.
      expect(question.country, 'Vietnam');
      expect(question.countryID, equals(dummyData[0].id));
    });
    test('Vietnam chances should raise by 2 after first time getQuestion()',
        () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      sampleNode.getQuestion();
      // assertion.
      expect(sampleNode.testCountries()[0].chances, equals(2));
    });
    test('America chances should not be affected.', () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      sampleNode.getQuestion();
      // assertion.
      expect(sampleNode.testCountries()[1].chances, equals(0));
    });
    test('Cursor should be moved by one.', () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      sampleNode.getQuestion();
      // assertion.
      expect(sampleNode.testCursor(), equals(1));
    });
  });

  group('Second time get question.', () {
    test('Second Question should not be null', () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      // assertion.
      expect(question, isNotNull);
    });
    test('Second Question should be America', () {
      // init data.
      var sampleNode = Node(dummyData[0]);
      sampleNode.insert(dummyData[1]);
      // check if cursor start at offset 0.
      expect(sampleNode.testCursor(), equals(0));
      // get first question.
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      // assertion.
      expect(question.country, equals('America'));
      expect(question.countryID, equals(dummyData[1].id));
    });
    test('Vietnam chances should remain unchanged', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[0].chances, equals(2));
    });
    test('Cursor should equal to countries length.', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(
          sampleNode.testCursor(), equals(sampleNode.testCountries().length));
    });

    test('Return question should be null', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(question, isNull);
    });
    test('Vietnam chances should remain unchanged', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[0].chances, equals(2));
    });
    test('America chances should remain unchanged', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[1].chances, equals(2));
    });
    test('Cursor should get back to 0', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCursor(), equals(0));
    });

    test('Return question should be null', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(question, isNull);
    });
    test('Vietnam chances should reduce by One.', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[0].chances, equals(1));
    });
    test('America chances should reduce by One.', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[1].chances, equals(1));
    });
    test('Cursor should get back to 0', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCursor(), equals(0));
    });

    test('Cursor still at 0', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCursor(), equals(0));
    });
    test('Return question should not be null', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(question, isNotNull);
    });
    test('Return question should be Vietnam 1', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(question.country, 'Vietnam');
      expect(question.countryID, equals(dummyData[0].id));
    });
    test('Vietnam chances should raise by 2', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[0].chances, equals(2));
    });
    test('America chances should not be affected', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCountries()[1].chances, equals(0));
    });
    test('Cursor should move by One.', () {
      var sampleNode = Node(dummyData[0]);
      var question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      question = sampleNode.getQuestion();
      expect(sampleNode.testCursor(), equals(1));
    });
  });

  group('Third time get question.', () {});
}
