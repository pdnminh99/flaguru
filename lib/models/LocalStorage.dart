import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<Settings> getExistingSettings() async {
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

  Future<void> updateNewSettings(Settings newSettings) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("audio", newSettings.isAudioON);
    pref.setBool("sound", newSettings.isSoundON);
    pref.setBool("skipTutorials", newSettings.skipTutorials);
  }

  // comment this if this func not working
  Future<void> newRound(Difficulty level) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    var playcount = pref.getInt('${symbol}played');
    if (playcount == null)
      pref.setInt('${symbol}played', 1);
    else
      pref.setInt('${symbol}played', playcount + 1);
  }

  // uncomment this if the other func not working
  // Future<void> newRound(Difficulty level) {
  //   var symbol = _getSymbol(level);
  //   return SharedPreferences.getInstance().then((pref) {
  //     var playcount = pref.getInt('${symbol}played');
  //     if (playcount == null)
  //       pref.setInt('${symbol}played', 1);
  //     else
  //       pref.setInt('${symbol}played', playcount + 1);
  //   });
  // }

  // comment this if this func is not working
  Future<void> saveResult(int newScore, Difficulty level, bool isWin) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    var lastHighestScore = pref.getInt('${symbol}score');
    var winning = pref.getInt('${symbol}win');
    var totalScore = pref.getInt('totalscore');
    if (lastHighestScore == null || lastHighestScore < newScore)
      pref.setInt('${symbol}score', newScore);
    // if (winning == null)
    //   pref.setInt('${symbol}win', 0);
    // else if (isWin) pref.setInt('${symbol}win', winning + 1);
    pref.setInt(
        '${symbol}win', winning == null ? 0 : isWin ? winning + 1 : winning);
    pref.setInt(
        'totalscore', totalScore == null ? totalScore : totalScore + newScore);
  }
  // // uncomment this if the other func not working
  // Future<void> saveResult(int newScore, Difficulty level, bool isWin) {
  //   var symbol = _getSymbol(level);
  //   return SharedPreferences.getInstance().then((pref) {
  //     var lastHighestScore = pref.getInt('${symbol}score');
  //     var winning = pref.getInt('${symbol}win');
  //     if (lastHighestScore == null || lastHighestScore < newScore)
  //       pref.setInt('${symbol}score', newScore);
  //     if (winning == null)
  //       pref.setInt('${symbol}win', 0);
  //     else if (isWin) pref.setInt('${symbol}win', winning + 1);
  //     pref.setInt('totalscore', pref.getInt('totalscore') + newScore);
  //   });
  // }

  // int getHighestScore(Difficulty level) => pref.getInt('EASYscore');

  Future<Map<String, int>> getLocalResult(Difficulty level) async {
    var symbol = _getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    return {
      'highestScore': pref.getInt('${symbol}score'),
      'playedCount': pref.getInt('${symbol}played'),
      'winningCount': pref.getInt('${symbol}win'),
      'totalScore': pref.getInt('totalscore'),
    };
  }

  String _getSymbol(Difficulty level) {
    switch (level) {
      case Difficulty.EASY:
        return 'EASY';
      case Difficulty.NORMAL:
        return 'NORMAL';
      case Difficulty.HARD:
        return 'HARD';
      default:
        return 'EASY';
    }
  }
}
