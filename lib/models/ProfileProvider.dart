import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flaguru/models/RoundDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider {
  var _localStorage = LocalStorage();

  Future<RoundDetails> getLocalResult(Difficulty level) async {
    var symbol = _localStorage.getSymbol(level);
    var pref = await SharedPreferences.getInstance();
    var highestScore = pref.getInt('${symbol}score');
    var playedCount = pref.getInt('${symbol}played');
    var winningCount = pref.getInt('${symbol}win');
    return RoundDetails(
        highestScore: highestScore,
        winningCount: winningCount,
        playedCount: playedCount,
        level: level);
  }

  // ProfileProvider._internal();

  // static ProfileProvider profileInstance;

  // static Future<ProfileProvider> getInstance() async {
  //   if (profileInstance == null) {
  //     profileInstance = ProfileProvider._internal();
  //   }
  //   return profileInstance;
  // }



  // Future<Map<String, int>> getData(Difficulty level) async {
  //   return {
  //     'HighestScore': await this._localStorage.getHighestScore(level),
  //     'Win': await this._localStorage.getWin(level),
  //     'Played': await this._localStorage.getPlayed(level),
  //   };
  // }
}

