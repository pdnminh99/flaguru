import 'package:flutter/material.dart';

class User {
  String _uuid;
  String _name;
  String _avatar;
  String _email;

  String get uuid {
    return this._uuid;
  }

  set uuid(String value) {
    this._uuid = value;
  }

  String get name {
    return this._name;
  }

  set name(String value) {
    this._name = value;
  }

  String get avatar {
    return this._avatar;
  }

  set avatar(String value) {
    this._avatar = value;
  }

  String get email {
    return this._email;
  }

  set email(String value) {
    this._email = value;
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

  @override
  String toString() => 'User $uuid, name $name, email $email';
}
