import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider {
  var _localStorage = LocalStorage();

  ProfileProvider._internal();

  static ProfileProvider profileInstance;

  static Future<ProfileProvider> getInstance() async {
    if (profileInstance == null) {
      profileInstance = ProfileProvider._internal();
    }
    return profileInstance;
  }

  // Future<Map<String, int>> getData(Difficulty level) async {
  //   return {
  //     'HighestScore': await this._localStorage.getHighestScore(level),
  //     'Win': await this._localStorage.getWin(level),
  //     'Played': await this._localStorage.getPlayed(level),
  //   };
  // }
}

