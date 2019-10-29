import 'package:flaguru/models/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'User.dart';

class SharedPreference {
  Future<Settings> getExistingSettings(User currentUser) async {
    var localSettings = await SharedPreferences.getInstance();
    var audio = localSettings.getBool("audio");
    var sound = localSettings.getBool("sound");
    var skipTutorials = localSettings.getBool("skipTutorials");
    if (audio == null || sound == null || skipTutorials == null) return null;
    return Settings(
        isAudioON: audio,
        isSoundON: sound,
        skipTutorials: skipTutorials,
        newUser: currentUser);
  }

  Future<bool> initializeNewSettings(Settings newSettings) async {
    try {
      var localSettings = await SharedPreferences.getInstance();
      localSettings.setBool("audio", newSettings.isAudioON);
      localSettings.setBool("sound", newSettings.isSoundON);
      localSettings.setBool("skipTutorials", newSettings.skipTutorials);
      return true;
    } catch (Exception) {
      return false;
    }
  }
}
