//import 'package:flaguru/models/RoundHandler.dart';
//import 'package:test/test.dart';
//
//void main() {
//  group('Default params', () {
//    test('Created instance is not null', () async {
//      var instance = await RoundHandler.getInstance();
//      expect(instance, isNotNull);
//    });
//
//    test('Question is not null', () async {
//      var instance = await RoundHandler.getInstance();
//      expect(instance.question, isNotNull);
//    });
//
//    test('4 answers is generated', () async {
//      var instance = await RoundHandler.getInstance();
//      expect(instance.answers.length, equals(4));
//    });
//
//    test('isAlive', () async {
//      var instance = await RoundHandler.getInstance();
//      expect(instance.isAlive, isTrue);
//      expect(instance.remainLives, equals(5));
//    });
//
//    test('passed Questions should start at 1.', () async {
//      var instance = await RoundHandler.getInstance();
//      expect(instance.passedQuestions, equals(1));
//    });
//  });
//}
