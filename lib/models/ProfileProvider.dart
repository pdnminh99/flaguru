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

  Set<Map<String, Future<int>>> getData(Difficulty level) => {
    {
      'HighestScore': this._localStorage.getHighestScore(level),
      'Win': this._localStorage.getWin(level),
      'Played': this._localStorage.getPlayed(level),
    }
  };
}

