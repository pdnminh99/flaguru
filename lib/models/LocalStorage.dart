import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/RoundDetails.dart';
import 'package:flaguru/models/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<Settings> getExistingSettings() async {
    var localSettings = await SharedPreferences.getInstance();
    var audio = localSettings.getBool("audio");
    var sound = localSettings.getBool("sound");
    var skipTutorials = localSettings.getBool("skipTutorials");
    if (audio == null || sound == null || skipTutorials == null) {
      var newSettings = Settings();
      await updateNewSettings(newSettings);
      return newSettings;
    }
    return Settings(
      isAudioON: audio,
      isSoundON: sound,
      skipTutorials: skipTutorials,
    );
  }

  static Future<void> updateNewSettings(Settings newSettings) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("audio", newSettings.isAudioON);
    pref.setBool("sound", newSettings.isSoundON);
    pref.setBool("skipTutorials", newSettings.skipTutorials);
  }

  static Future<void> newRound(Difficulty level) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    var playCount = pref.getInt('${symbol}played');
    if (playCount == null)
      pref.setInt('${symbol}played', 1);
    else
      pref.setInt('${symbol}played', playCount + 1);
  }

  static Future<void> saveResult(
      int newScore, Difficulty level, bool isWin) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    var lastHighestScore = pref.getInt('${symbol}score');
    var winning = pref.getInt('${symbol}win');
    var totalScore = pref.getInt('totalscore');
    if (lastHighestScore == null || lastHighestScore < newScore)
      pref.setInt('${symbol}score', newScore);
    if (winning == null)
      pref.setInt('${symbol}win', 0);
    else if (isWin) pref.setInt('${symbol}win', winning + 1);
    pref.setInt(
        'totalscore', totalScore == null ? totalScore : totalScore + newScore);
  }

  static Future<RoundDetails> getLocalResult(Difficulty level) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    return RoundDetails(
        highestScore: pref.getInt('${symbol}score'),
        winningCount: pref.getInt('${symbol}win'),
        playedCount: pref.getInt('${symbol}played'),
        level: level);
  }

  static String _getSymbol(Difficulty level) {
    switch (level) {
      case Difficulty.EASY:
        return 'EASY';
      case Difficulty.NORMAL:
        return 'NORMAL';
      case Difficulty.HARD:
        return 'HARD';
      case Difficulty.ENDLESS:
        return 'ENDLESS';
      default:
        return 'EASY';
    }
  }

  Future<String> getTotalScore() async =>
      (await SharedPreferences.getInstance()).getInt('totalscore').toString();

  static Future<DateTime> queryLastTimeUpdates() async {
    var lastTimeUpdateString =
        (await SharedPreferences.getInstance()).getString('lasttimeupdate');
    return lastTimeUpdateString == null
        ? null
        : DateTime.parse(lastTimeUpdateString);
  }

  static Future<bool> updateLastTimeUpdate() async {
    try {
      (await SharedPreferences.getInstance())
          .setString('lasttimeupdate', DateTime.now().toString());
      return true;
    } catch (Exception) {
      return false;
    }
  }
}
