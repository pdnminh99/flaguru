import 'Enum.dart';

class Rule {
  Difficulty _diff;
  int _quizTotal;
  int _timeLimit;
  int _maxLife;

  Rule(Difficulty difficulty) {
    _diff = difficulty;
    switch (difficulty) {
      case Difficulty.EASY:
        _quizTotal = 20;
        _timeLimit = 15;
        _maxLife = 5;
        break;
      case Difficulty.NORMAL:
        _quizTotal = 20;
        _timeLimit = 15;
        _maxLife = 4;
        break;
      case Difficulty.HARD:
        _quizTotal = 20;
        _timeLimit = 15;
        _maxLife = 3;
        break;
      case Difficulty.ENDLESS:
        _quizTotal = 99999;
        _timeLimit = 20;
        _maxLife = 1;
        break;
    }
  }

  Difficulty get difficulty => _diff;

  int get quizTotal => _quizTotal;

  int get timeLimit => _timeLimit;

  int get maxLife => _maxLife;
}
