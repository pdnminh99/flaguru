import '../models/Enum.dart';

class EnumString {
  static String getDifficulty(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.EASY:
        return 'Easy';
      case Difficulty.NORMAL:
        return 'Normal';
      case Difficulty.HARD:
        return 'Hard';
      case Difficulty.ENDLESS:
        return 'Endless';
      default:
        return '';
    }
  }
}
