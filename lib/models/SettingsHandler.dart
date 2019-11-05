import 'package:flaguru/models/Settings.dart';
import 'package:flaguru/utils/global_audio_player.dart';
import 'package:flutter/cupertino.dart';

import 'LocalStorage.dart';

class SettingsHandler with ChangeNotifier {
  Settings _currentSettings;

  bool get isSoundEnabled {
    return this._currentSettings.isSoundON;
  }

  set isSoundEnabled(bool newState) {
    this._currentSettings.isSoundON = newState;
    LocalStorage.updateNewSettings(this._currentSettings)
        .catchError((error) => print(error));
    notifyListeners();
  }

  bool get isMusicEnabled {
    return this._currentSettings.isAudioON;
  }

  set isMusicEnabled(bool newState) {
    this._currentSettings.isAudioON = newState;
    LocalStorage.updateNewSettings(this._currentSettings)
        .catchError((error) => print(error));
    newState ? audioPlayer?.playMusic() : audioPlayer?.pauseMusic();
    notifyListeners();
  }

  bool get skipTutorials {
    return this._currentSettings.skipTutorials;
  }

  set skipTutorials(bool newState) {
    this._currentSettings.skipTutorials = newState;
    LocalStorage.updateNewSettings(this._currentSettings)
        .catchError((error) => print(error));
    notifyListeners();
  }

  SettingsHandler._internal();

  static SettingsHandler settingInstance;

  static Future<SettingsHandler> getInstance() async {
    if (settingInstance == null) {
      settingInstance = SettingsHandler._internal();
      settingInstance._currentSettings =
          await LocalStorage.getExistingSettings();
    }
    return settingInstance;
  }

  void resetSettings() {
    this._currentSettings.isAudioON = true;
    this._currentSettings.isSoundON = true;
    this._currentSettings.skipTutorials = false;
    LocalStorage.updateNewSettings(this._currentSettings);
  }
}
