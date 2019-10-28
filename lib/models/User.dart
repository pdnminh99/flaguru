import 'package:flutter/material.dart';

class User {
  String _uuid;
  String _name;
  String _avatar;
  String _email;

  String get uuid {
    return this._uuid;
  }

  String get name {
    return this._name;
  }

  String get avatar {
    return this._avatar;
  }

  String get email {
    return this._email;
  }

  User({
    @required String uuid,
    @required String name,
    @required String avatar,
    @required String email,
  }) {
    this._uuid = uuid;
    this._name = name;
    this._avatar = avatar;
    this._email = email;
  }
}
