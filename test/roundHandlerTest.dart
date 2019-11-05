import 'package:flaguru/models/RoundHandler.dart';
import 'package:test/test.dart';

void main() {
  test('Instance is not null', () async {
    var handlerInstance = await RoundHandler.getInstance();
    expect(handlerInstance.question, equals(null));
    expect(handlerInstance.answers, equals(null));
  });
}
