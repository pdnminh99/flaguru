import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/Country.dart';
import 'package:flutter/foundation.dart';
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
    if (this._db == null) this._db = await openDatabase(path);
  }

  Future<List<Country>> collectCountries({count: 0}) async {
    await _connectSQLite();
    var maps = List<Map>();
    //    if (count == 0)
    //      maps = await this._db.rawQuery("SELECT * FROM country");
    //    else
    //      maps = await this
    //          ._db
    //          .rawQuery("SELECT * FROM country ORDER BY RANDOM() LIMIT $count");
    maps = await this._db.rawQuery("SELECT * FROM country ORDER BY ratio ASC");
    for (var item in maps) print(item.keys);
    var countries = List.generate(maps.length, (i) {
      // print(maps[i]['ratio']);
      return Country(
        id: maps[i]['ID'],
        name: maps[i]['name'],
        flag: maps[i]['flag'],
        // callCounter: maps[i]['callcounter'],
        // correctCounter: maps[i]['correctcounter'],
        ratio: maps[i]['ratio'],
        description: maps[i]['description'],
      );
    });
    // await this._db.close();
    return countries;
  }

  Future<void> updateChances({@required int countryID, int chances}) =>
      this._connectSQLite().then((_) => this._db.rawInsert(
          'UPDATE country SET chances = $chances WHERE ID = $countryID'));

  // Future<void> updateRatio(Country country) =>
  //     this._connectSQLite().then((_) => this._db.rawUpdate(
  //         'UPDATE country SET callcounter = ${country.callCounter}, correctcounter = ${country.correctCounter}, ratio = ${country.ratio} WHERE ID = ${country.id}'));
}
