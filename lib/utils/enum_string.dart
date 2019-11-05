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
      default:
        return '';
    }
  }
}
