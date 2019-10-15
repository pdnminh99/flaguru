import 'package:flaguru/models/Enum.dart';

class EnumString {
  static String getDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return 'easy';
      case Difficulty.NORMAL:
        return 'normal';
      case Difficulty.HARD:
        return 'hard';
      default:
        return '';
    }
  }
}
