import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Settings.dart';
import 'package:flaguru/models/User.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnector {
  Future<Database> _db;

  Future<Database> _connectSQLite() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'flaguru.db');
    if (_db == null) {
      // Delete any existing database:
      await deleteDatabase(path);
      // Copy database from flutter's asset to application's asset
      ByteData data = await rootBundle.load("assets/database/flaguru.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      // Open database
      _db = openDatabase(path);
    }
    return _db;
  }

  Future<List<Country>> collectCountries({count: 0}) async {
    var database = await this._connectSQLite();
    var maps = List<Map>();
    if (count == 0) {
      maps = await database.rawQuery("SELECT * FROM country");
    } else {
      maps = await database
          .rawQuery("SELECT * FROM country ORDER BY RANDOM() LIMIT $count");
    }
    var countries = List.generate(maps.length, (i) {
      return Country(
        id: maps[i]['ID'],
        name: maps[i]['name'],
        flag: maps[i]['flag'],
        ratio: maps[i]['ratio'],
        description: maps[i]['description'],
      );
    });
    await database.close();
    return countries;
  }

  Future<void> deleteCountries() async {
    var database = await this._connectSQLite();
    await database.rawDelete("DELETE FROM country");
    await database.close();
  }

  Future<Settings> collectExistingSettings(User currentUser) async {
    var database = await this._connectSQLite();
    var maps = await database
        .rawQuery("SELECT * FROM settings WHERE user='${currentUser.uuid}'");
    database.close();
    if (maps.length == 0) return null;
    if (maps.length > 1)
      throw Exception(
          "Why there are two users with the same user in Settings table?");
    print(maps);
    return Settings(
        isAudioON: maps[0]['audio'] == 0 ? false : true,
        isSoundON: maps[0]['sound'] == 0 ? false : true,
        skipTutorials: maps[0]['skiptutorials'] == 0 ? false : true,
        newUser: currentUser);
  }

  Future<void> updateExistingSettings(
      String currentUUID, Settings newSettings) async {
    var database = await this._connectSQLite();
    await database.rawUpdate(
        "UPDATE settings SET sound=${newSettings.isSoundON ? 1 : 0}, audio=${newSettings.isAudioON ? 1 : 0} WHERE user=$currentUUID");
    database.close();
  }

  void updateExistingSettingsSync(String currentUUID, Settings newSettings) {
    this
        ._connectSQLite()
        .then((database) => database
            .rawUpdate(
                "UPDATE settings SET sound=${newSettings.isSoundON ? 1 : 0}, audio=${newSettings.isAudioON ? 1 : 0} WHERE user=$currentUUID")
            .then((_) => database.close()))
        .catchError((error) => print(error));
  }

  void saveNewSettingsSync(String currentUUID, Settings newSettings) {
    this
        ._connectSQLite()
        .then((database) => database
            .rawInsert(
                "INSERT INTO settings(user, sound, audio, skiptutorials) VALUES ('$currentUUID', ${newSettings.isSoundON ? 1 : 0}, ${newSettings.isAudioON ? 1 : 0}, ${newSettings.skipTutorials ? 1 : 0})")
            .then((_) => database.close()))
        .catchError((error) => print(error));
  }

  Future<void> saveNewSettings(String currentUUID, Settings newSettings) async {
    var database = await this._connectSQLite();
    await database.rawInsert(
        "INSERT INTO settings(user, sound, audio, skiptutorials) VALUES ('$currentUUID', ${newSettings.isSoundON ? 1 : 0}, ${newSettings.isAudioON ? 1 : 0}, ${newSettings.skipTutorials ? 1 : 0})");
    database.close();
  }
}
