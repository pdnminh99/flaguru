import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // found that if chances equals 0 -> cause many errors.
  var dummyData = [
    Country(
      id: 1,
      name: 'Vietnam',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 2,
      name: 'America',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 3,
      name: 'Japan',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 4,
      name: 'Deutch',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 5,
      name: 'German',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 6,
      name: 'Laos',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 7,
      name: 'Singapore',
      ratio: 100,
      chances: 0,
    ),
    Country(
      id: 8,
      name: 'Malaysia',
      ratio: 100,
      chances: 0,
    ),
  ];
  var falseCountry = Country(id: 10, name: 'Wakanda', ratio: 0, chances: 0);
  group('Initializing test.', () {
    var sampleNode = Node(dummyData[0]);
    test('New node is not null.', () => expect(sampleNode, isNotNull));
    test('There should be at least 1 country', () {
      var countries = sampleNode.testCountries();
      expect(countries.length, equals(1));
    });
    test('First country should be Vietnam', () {
      var countries = sampleNode.testCountries();
      expect(countries[0], equals(dummyData[0]));
    });
    test('Ratio should be equal Vietnam', () {
      var ratio = sampleNode.testRatio();
      expect(ratio, equals(dummyData[0].ratio));
    });
    test('Startup cursor should be at 0',
        () => expect(sampleNode.testCursor(), equals(0)));
    test('isEmpty method works', () => expect(sampleNode.isEmpty(), isFalse));
    test('first country chances should be 0',
        () => expect(sampleNode.testCountries()[0].chances, equals(0)));
  });

  group('In use test', () {
    var sampleNode = Node(dummyData[0]);
    test('insert func success.', () {
      expect(sampleNode.insert(dummyData[1]), isTrue);
    });
    test('Node length should be 2 after insert',
        () => expect(sampleNode.testCountries().length, equals(2)));
    test('Inserted country should be America.',
        () => expect(sampleNode.testCountries()[1], equals(dummyData[1])));
    test('Inserting country with different ratio should raise a false.',
        () => expect(sampleNode.insert(falseCountry), isFalse));
    test('The false country is not inserted.', () {
      expect(sampleNode.testCountries().length, equals(2));
      expect(sampleNode.testCountries()[1], equals(dummyData[1]));
    });
    test('Cursor should move by one.', () {
      sampleNode.moveCursor();
      expect(sampleNode.testCursor(), equals(1));
    });
    test('Cursor should move back to zero when reach its limit.', () {
      sampleNode.moveCursor();
      expect(sampleNode.testCursor(), equals(0));
    });

    /* > Before call getQuestion().
     * > Country:  Vietnam*   |   America
     * > Chances:     0              0
     */

    var question = sampleNode.getQuestion();
    print(question.toString());

    /* > After call getQuestion().
     * > Country:  Vietnam   |   America*
     * > Chances:     2              0
     */

    test('Return question should not be null',
        () => expect(question, isNotNull));
    test('Return question should be Vietnam 1',
        () => expect(question.country, 'Vietnam'));
    test('Return question should be Vietnam 2',
        () => expect(question, equals(dummyData[0].toQuestion())));
    test('Vietnam chances should raise by 2',
        () => expect(sampleNode.testCountries()[0].chances, equals(2)));
    test('America chances should not be affected',
        () => expect(sampleNode.testCountries()[1].chances, equals(0)));
    test('Cursor should be moved by one.',
        () => expect(sampleNode.testCursor(), equals(1)));

    // > Before call getQuestion() -> Same as above.

    question = sampleNode.getQuestion();

    /* > After call getQuestion().
     * > Country:  Vietnam   |   America  |  *
     * > Chances:     2              2
     */

    test('Return question should not be null',
        () => expect(question, isNotNull));
    test('Return question should be America 1',
        () => expect(question.country, 'America'));
    test('Return question should be America 2',
        () => expect(question, dummyData[1].toQuestion()));
    test('America chances should raise by 2',
        () => expect(sampleNode.testCountries()[1].chances, equals(2)));
    test('Vietnam chances should remain unchanged',
        () => expect(sampleNode.testCountries()[0].chances, equals(2)));
    test(
        'Cursor should equal to countries length.',
        () => expect(sampleNode.testCursor(),
            equals(sampleNode.testCountries().length)));

    // > Before call getQuestion() -> Same as above.

    question = sampleNode.getQuestion();

    /* > After call getQuestion().
     * > Country:  Vietnam*   |   America
     * > Chances:     2              2
     */

    test('Return question should be null', () => expect(question, isNull));
    test('Vietnam chances should remain unchanged',
        () => expect(sampleNode.testCountries()[0].chances, equals(2)));
    test('America chances should remain unchanged',
        () => expect(sampleNode.testCountries()[1].chances, equals(2)));
    test('Cursor should get back to 0',
        () => expect(sampleNode.testCursor(), equals(0)));

    // > Before call getQuestion() -> Same as above.

    question = sampleNode.getQuestion();

    /* > After call getQuestion().
     * > Country:  Vietnam*   |   America
     * > Chances:     1              1
     */

    test('Return question should be null', () => expect(question, isNull));
    test('Vietnam chances should reduce by One.',
        () => expect(sampleNode.testCountries()[0].chances, equals(1)));
    test('America chances should reduce by One.',
        () => expect(sampleNode.testCountries()[1].chances, equals(1)));
    test('Cursor should get back to 0',
        () => expect(sampleNode.testCursor(), equals(0)));

    // > Before call getQuestion() -> Same as above.

    question = sampleNode.getQuestion();

    /* > After call getQuestion().
     * > Country:  Vietnam*   |   America
     * > Chances:     0              0
     */
    test('Cursor still at 0', () => expect(sampleNode.testCursor(), equals(0)));
    question = sampleNode.getQuestion();

    /* > After call getQuestion().
     * > Country:  Vietnam   |   America*
     * > Chances:     2              0
     */

    test('Return question should not be null',
        () => expect(question, isNotNull));
    test('Return question should be Vietnam 1',
        () => expect(question.country, 'Vietnam'));
    test('Return question should be Vietnam 2',
        () => expect(question, equals(dummyData[0].toQuestion())));
    test('Vietnam chances should raise by 2',
        () => expect(sampleNode.testCountries()[0].chances, equals(2)));
    test('America chances should not be affected',
        () => expect(sampleNode.testCountries()[1].chances, equals(0)));
    test('Cursor should move by One.',
        () => expect(sampleNode.testCursor(), equals(1)));
  });
}
