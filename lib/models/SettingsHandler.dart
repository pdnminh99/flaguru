import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/Settings.dart';
import 'package:flaguru/models/User.dart';

class SettingsHandler {
  Settings _currentSettings;

  bool get isSoundEnabled {
    return this._currentSettings.isSoundON;
  }

  set isSoundEnabled(bool newstate) {
    var database = DatabaseConnector();
    this._currentSettings.isSoundON = newstate;
    database
        .updateExistingSettingsSync(
            this._currentSettings.currentUser.uuid, this._currentSettings)
        .catchError((error) => print(error));
  }

  bool get isAudioEnabled {
    return this._currentSettings.isAudioON;
  }

  set isAudioEnabled(bool newstate) {
    this._currentSettings.isAudioON = newstate;
    var database = DatabaseConnector();
    database
        .updateExistingSettingsSync(
            this._currentSettings.currentUser.uuid, this._currentSettings)
        .catchError((error) => print(error));
  }

  bool get skipTutorials {
    return this._currentSettings.skipTutorials;
  }

  set skipTutorials(bool newstate) {
    this._currentSettings.skipTutorials = newstate;
    var database = DatabaseConnector();
    database
        .updateExistingSettingsSync(
            this._currentSettings.currentUser.uuid, this._currentSettings)
        .catchError((error) => print(error));
  }

  SettingsHandler._internal();

  static SettingsHandler settingInstance;

  static Future<SettingsHandler> getInstance() async {
    if (settingInstance == null) {
      var fakeUser = User(
        uuid: '2170000',
        name: 'Mr.Bean',
        email: 'teddy@gmail.com',
        avatar:
            'https://i.etsystatic.com/7012839/r/il/fb9aad/1511132304/il_570xN.1511132304_rtxl.jpg',
      );
      settingInstance = SettingsHandler._internal();
      settingInstance._currentSettings = Settings(newUser: fakeUser);
      await settingInstance._queryExistingSettings();
    }
    return settingInstance;
  }

  // /*
  //  * THESE MUST BE CALLED WITH AWAIT
  //  */
  // Future<void> switchAudio() async {
  //   this._currentSettings.isAudioON = !this.isAudioEnabled;
  //   var databaseConn = DatabaseConnector();
  //   await databaseConn.updateExistingSettings(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  // Future<void> switchSound() async {
  //   this._currentSettings.isSoundON = !this.isSoundEnabled;
  //   var databaseConn = DatabaseConnector();
  //   await databaseConn.updateExistingSettings(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  // Future<void> finishTutorials() async {
  //   this._currentSettings.skipTutorials = true;
  //   var databaseConn = DatabaseConnector();
  //   await databaseConn.updateExistingSettings(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  // /*
  //  * NOT CALLED WITH AWAIT
  //  */
  // void switchAudioSync() {
  //   this._currentSettings.isAudioON = !this.isAudioEnabled;
  //   var databaseConn = DatabaseConnector();
  //   databaseConn.updateExistingSettingsSync(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  // void switchSoundSync() {
  //   this._currentSettings.isSoundON = !this.isSoundEnabled;
  //   var databaseConn = DatabaseConnector();
  //   databaseConn.updateExistingSettingsSync(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  // void finishTutorialsSync() {
  //   this._currentSettings.skipTutorials = true;
  //   var databaseConn = DatabaseConnector();
  //   return databaseConn.updateExistingSettingsSync(
  //       this._currentSettings.currentUser.uuid, this._currentSettings);
  // }

  /*
   * OTHERs METHODS
   */
  Future<void> _queryExistingSettings() async {
    var databaseConn = DatabaseConnector();
    var newsettings = await databaseConn
        .collectExistingSettings(this._currentSettings.currentUser);
    if (newsettings != null) {
      print("Found an existing settings $newsettings");
      print(newsettings.toString());
      if (newsettings.isAudioON != this.isAudioEnabled)
        this._currentSettings.isAudioON = newsettings.isAudioON;
      if (newsettings.isSoundON != this.isSoundEnabled)
        this._currentSettings.isSoundON = newsettings.isSoundON;
      if (newsettings.skipTutorials != this.skipTutorials)
        this._currentSettings.skipTutorials = newsettings.skipTutorials;
    } else {
      print("Could not found any existing settings $newsettings");
      await _initializeDefaultSettings();
    }
  }

  Future<void> _initializeDefaultSettings() async {
    var databaseConn = DatabaseConnector();
    await databaseConn.saveNewSettings(
        this._currentSettings.currentUser.uuid, this._currentSettings);
  }

  @override
  String toString() =>
      "Setting of user ${this._currentSettings.currentUser.name}: Audio ${this.isAudioEnabled ? 'ON' : 'OFF'}, Sound ${this.isSoundEnabled ? 'ON' : 'OFF'} and skip Tutorials ${this.skipTutorials ? 'ON' : 'OFF'}";
}
