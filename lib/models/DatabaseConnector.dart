import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/Country.dart';
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
        id: maps[i]['ID'].toString(),
        name: maps[i]['name'],
        flag: maps[i]['flag'],
        ratio: maps[i]['ratio'],
        description: maps[i]['description'],
      );
    });
    await database.close();
    return countries;
  }

  Future<void> deleteAllData() async {
    var database = await this._connectSQLite();
    await database.rawDelete("DELETE FROM country");
    await database.close();
  }
}
