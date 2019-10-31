import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/Country.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnector {
  Database _db;

  Future<void> _connectSQLite() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'flaguru.db');
    // Delete any existing database:
    await deleteDatabase(path);
    // Copy database from flutter's asset to application's asset
    ByteData data = await rootBundle.load("assets/database/flaguru.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    // Open database
    this._db = await openDatabase(path);
  }

  Future<List<Country>> collectCountries({count: 0}) async {
    await _connectSQLite();
    var maps = List<Map>();
    if (count == 0)
      maps = await this._db.rawQuery("SELECT * FROM country");
    else
      maps = await this
          ._db
          .rawQuery("SELECT * FROM country ORDER BY RANDOM() LIMIT $count");
    var countries = List.generate(maps.length, (i) {
      return Country(
        id: maps[i]['ID'],
        name: maps[i]['name'],
        flag: maps[i]['flag'],
        ratio: maps[i]['ratio'],
        description: maps[i]['description'],
      );
    });
    await this._db.close();
    return countries;
  }

  void countryCalled(Country country) {
    this._connectSQLite().then((database) {
      // database.rawQuery('SELECT')
    }).catchError((error) {
      print(error);
      // TODO send error message to firebase
    });
  }
}
