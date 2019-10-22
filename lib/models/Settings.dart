import 'package:flaguru/models/User.dart';
import 'package:flutter/widgets.dart';

class Settings {
  User _currentUser;
  bool isAudioON;
  bool isSoundON;
  bool skipTutorials;
  User get currentUser {
    return this._currentUser;
  }

  Settings({
    this.isAudioON: true,
    this.isSoundON: true,
    this.skipTutorials: false,
    @required User newUser,
  }) {
    this._currentUser = newUser;
  }
}
