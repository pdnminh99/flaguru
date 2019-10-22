import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Settings.dart';

class SettingsHandler {
  var _currentSettings = Settings();
  bool get isSoundEnabled {
    return this._currentSettings.isSoundON;
  }

  bool get isAudioEnabled {
    return this._currentSettings.isAudioON;
  }

  SettingsHandler._internal();

  static SettingsHandler settingInstance;

  static Future<SettingsHandler> getInstance(String currentUUID) async {
    if (settingInstance == null) {
      settingInstance = SettingsHandler._internal();
    }
    await settingInstance._queryExistingSettingsSync(currentUUID);
    return settingInstance;
  }

  void switchAudio({bool saveDatabase: true}) {}

  Future<bool> _queryExistingSettingsSync(String currentUUID) async {
    var databaseConn = DatabaseConnector();
    var newsettings = await databaseConn.collectExistingSettings(currentUUID);
    if (newsettings == null) return false;
    if (newsettings.isAudioON != this.isAudioEnabled)
      this._currentSettings.isAudioON = newsettings.isAudioON;
    if (newsettings.isSoundON != this.isSoundEnabled)
      this._currentSettings.isSoundON = newsettings.isSoundON;
    return true;
  }
}
