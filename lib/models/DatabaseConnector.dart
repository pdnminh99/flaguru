import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Enum.dart';

class DatabaseConnector {
  // database props
  Database _db;
  Batch _transactionQueue;

  bool get isAlive => _db != null && _db.isOpen;

  // more props
  var privateLogs = List<AnswerLog>();

  /*
   * Singleton code.
   */
  DatabaseConnector._internal();

  static DatabaseConnector connectorInstance;

  static Future<DatabaseConnector> getInstance() async {
    if (connectorInstance == null) {
      connectorInstance = DatabaseConnector._internal();
      await connectorInstance._connectSQLite();
    }
    return connectorInstance;
  }

  Future<void> _connectSQLite() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'flaguru.db');
    if (await databaseExists(path))
      print('Found database.');
    else {
      print('Database not found.');
      await deleteDatabase(path);
      ByteData data = await rootBundle.load("assets/database/flaguru.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
    _db = await openDatabase(path);
    _transactionQueue = _db.batch();
  }

  Continent _mapContinent(int continentID) {
    switch (continentID) {
      case 1:
        return Continent.EUROPE;
      case 2:
        return Continent.ASIA;
      case 3:
        return Continent.AFRICA;
      case 4:
        return Continent.AUSTRALIAandOCEANIA;
      case 5:
        return Continent.NORTH_AMERICA;
      case 6:
        return Continent.SOUTH_AMERICA;
      case 7:
        return Continent.ASIAandEUROPE;
      default:
        return Continent.EUROPE;
    }
  }

  int _mapStatusToInt(bool status) => status ? 1 : 0;

  Future<void> switchAllowStatus(bool newStatus, int countryID) =>
      _db.update('country', {'isallow': _mapStatusToInt(newStatus)},
          where: 'ID = ?', whereArgs: [countryID]);

//  Future<List<Country>> collectCountries({bool isAllowedOnly: true}) async {
//    await _connectSQLite();
//    var maps = List<Map>();
//    var query = 'SELECT * FROM country';
//    if (isAllowedOnly) query += ' WHERE isallow = 1;';
//    maps = await this._db.rawQuery(query);
//    // for (var item in maps) print(item.keys);
//    var countries = List.generate(
//        maps.length,
//        (i) => Country(
//              id: maps[i]['ID'],
//              name: maps[i]['name'],
//              flag: maps[i]['flag'],
//              callCounter: maps[i]['callcounter'],
//              correctCounter: maps[i]['correctcounter'],
//              description: maps[i]['description'],
//              chances: maps[i]['chances'],
//              continent: _mapContinent(maps[i]['continent']),
//              isAllow: maps[i]['isallow'] == 0 ? false : true,
//            ));
//    return countriesSortByRatio(countries);
//  }

  Future<List<Country>> collectCountries({bool isAllowedOnly: true}) async {
    var countries = List<Country>();
    print(_db.isOpen);
    var rawQueryResult = await _db.query('country');
    for (var country in rawQueryResult) {
      countries.add(Country(
          id: country['ID'],
          name: country['name'],
          flag: country['flag'],
          callCounter: country['callcounter'],
          correctCounter: country['correctcounter'],
          description: country['description'],
          chances: country['chances'],
          continent: _mapContinent(country['continent']),
          isAllow: country['isallow'] == 0 ? false : true));
    }
    return countriesSortByRatio(countries);
  }

  List<Country> countriesSortByRatio(List<Country> clusters) {
    for (var leftCursor = 0; leftCursor < clusters.length - 1; leftCursor++) {
      for (var rightCursor = clusters.length - 1;
          rightCursor > leftCursor;
          rightCursor--) {
        if (clusters[rightCursor - 1].ratio > clusters[rightCursor].ratio) {
          var temp = clusters[rightCursor - 1];
          clusters[rightCursor - 1] = clusters[rightCursor];
          clusters[rightCursor] = temp;
        }
      }
    }
    return clusters;
  }

  void addUpdateChancesTransaction({@required int countryID, int chances}) =>
      _transactionQueue.update('country', {'chances': chances},
          where: 'ID = ?', whereArgs: [countryID]);

  Future<void> commitUpdateChancesTransaction() =>
      _transactionQueue.commit(continueOnError: true, noResult: true);

  Future<void> updateCountryStats(AnswerLog newLog) => _db.rawUpdate(
      'UPDATE country SET callcounter = callcounter + 1${newLog.isCorrect ? ', correctcounter = correctcounter + 1' : ''} WHERE ID = ${newLog.question.countryID};');

  void addLog(AnswerLog newLog) => privateLogs.add(newLog);

  void saveLogs() {
    if (privateLogs.length == 0) return;
    var incrementCallCounterQuery = '''
    UPDATE country 
    SET callcounter = callcounter + 1
    WHERE ID IN (''';
    var isAtLeastOneCorrect = false;
    var incrementCorrectCounterQuery = '''
    UPDATE country 
    SET correctcounter = correctcounter + 1
    WHERE ID IN (''';
    // var insertQuery = '''
    //     INSERT INTO answerlog(questionID, answerID, isCorrect, logTime, answerTime)
    //     VALUES ''';
    for (var index = 0; index < privateLogs.length; index++) {
      // update query process
      incrementCallCounterQuery += '${privateLogs[index].question.countryID},';
      // incrementCallCounterQuery += index == privateLogs.length - 1 ? ');' : ',';
      if (privateLogs[index].isCorrect) {
        incrementCorrectCounterQuery +=
            '${privateLogs[index].question.countryID},';
        // incrementCorrectCounterQuery +=
        //     index == privateLogs.length - 1 ? ');' : ',';
        isAtLeastOneCorrect = true;
      }
      // insert query process
      // insertQuery +=
      //     '(${privateLogs[index].question.countryID}, ${privateLogs[index].answer.countryID}, ${privateLogs[index].isCorrect ? 1 : 0}, \'${DateTime.now().toString()}\', ${privateLogs[index].answerTime})';
      // insertQuery += index == privateLogs.length - 1 ? ';' : ', ';
    }
    privateLogs.clear();
    // try {
    incrementCallCounterQuery = incrementCallCounterQuery.substring(
            0, incrementCallCounterQuery.length - 1) +
        ');';
    if (isAtLeastOneCorrect) {
      incrementCorrectCounterQuery = incrementCorrectCounterQuery.substring(
              0, incrementCorrectCounterQuery.length - 1) +
          ');';
      _db
          .rawUpdate(incrementCallCounterQuery)
          .then((_) => print('Update callcounter successfully'))
          .then((_) => _db.rawUpdate(incrementCorrectCounterQuery))
          .then((_) => print('Update correctcounter callcounter successfully'))
          // .then((_) => _db.close())
          // .then((_) => _db.rawInsert(insertQuery))
          // .then((_) => print('Insert successfully'))
          .catchError((error) => print(error));
    } else {
      _db
          .rawUpdate(incrementCallCounterQuery)
          .then((_) => print('Update callcounter successfully'))
          // .then((_) => _db.close())
          // .then((_) => _db.rawInsert(insertQuery))
          // .then((_) => print('Insert successfully'))
          .catchError((error) => print(error));
    }
    // } catch (_) {
    //   print(
    //       'I know this bug. Which occured when player guessed so many flags that caused string overflow.');
    // }
  }

  Future<String> readLogs() => _db.rawQuery('''
          SELECT *
          FROM answerlog
          ''').then((maps) {
        // print('There are ${maps.length} answerlogs.');
        String logsString = '';
        int counter = 1;
        for (var map in maps) {
          logsString += '''
              $counter >>>>>>>>>>>>>>>>>>>>>>
              {
                qID: ${map['questionID']},
                aID: ${map['answerID']},
                isCorrect: ${map['isCorrect']},
                logTime: ${map['logTime']},
                answerTime: ${map['answerTime']}
              }
              ''';
          counter++;
        }
        return logsString;
      });

  Future<void> deleteLogs() => _db
      .delete('answerlog')
      // .then((_) => _db.close())
      .then((_) => print('Logs deleted successfully.'));
}

//class DatabaseConnector {
//  Database _db;
//  var privateLogs = List<AnswerLog>();
//
//  Future<void> _connectSQLite() async {
//    var dbPath = await getDatabasesPath();
//    var path = join(dbPath, 'flaguru.db');
//    // Delete any existing database:
//    await deleteDatabase(path);
//    // Copy database from flutter's asset to application's asset
//    ByteData data = await rootBundle.load("assets/database/flaguru.db");
//    List<int> bytes =
//    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//    await File(path).writeAsBytes(bytes);
//    // Open database
//    this._db = await openDatabase(path);
//  }
//
//  Continent mapContinent(int continentID) {
//    switch (continentID) {
//      case 1:
//        return Continent.EUROPE;
//      case 2:
//        return Continent.ASIA;
//      case 3:
//        return Continent.AFRICA;
//      case 4:
//        return Continent.AUSTRALIAandOCEANIA;
//      case 5:
//        return Continent.NORTH_AMERICA;
//      case 6:
//        return Continent.SOUTH_AMERICA;
//      case 7:
//        return Continent.ASIAandEUROPE;
//      default:
//        return Continent.EUROPE;
//    }
//  }
//
//  Future<void> switchAllowStatus(bool newStatus, int countryID) =>
//      _connectSQLite().then((_) => _db.rawUpdate(
//          'UPDATE country SET isallow = ${newStatus ? 1 : 0} WHERE ID = $countryID'));
//
//  Future<List<Country>> collectCountries({bool isAllowedOnly: true}) async {
//    await _connectSQLite();
//    var maps = List<Map>();
//    var query = 'SELECT * FROM country';
//    if (isAllowedOnly) query += ' WHERE isallow = 1;';
//    maps = await this._db.rawQuery(query);
//    // for (var item in maps) print(item.keys);
//    var countries = List.generate(
//        maps.length,
//            (i) => Country(
//          id: maps[i]['ID'],
//          name: maps[i]['name'],
//          flag: maps[i]['flag'],
//          callCounter: maps[i]['callcounter'],
//          correctCounter: maps[i]['correctcounter'],
//          description: maps[i]['description'],
//          chances: maps[i]['chances'],
//          continent: mapContinent(maps[i]['continent']),
//          isAllow: maps[i]['isallow'] == 0 ? false : true,
//        ));
//    // sort countries.
//    for (var leftCursor = 0; leftCursor < countries.length - 1; leftCursor++) {
//      for (var rightCursor = countries.length - 1;
//      rightCursor > leftCursor;
//      rightCursor--) {
//        if (countries[rightCursor - 1].ratio > countries[rightCursor].ratio) {
//          var temp = countries[rightCursor - 1];
//          countries[rightCursor - 1] = countries[rightCursor];
//          countries[rightCursor] = temp;
//        }
//      }
//    }
//    // await _db.close();
//    return countries;
//  }
//
//  Future<void> updateChances({@required int countryID, int chances}) => this
//      ._connectSQLite()
//      .then((_) => this._db.rawUpdate(
//      'UPDATE country SET chances = $chances WHERE ID = $countryID'));
//  // .then((_) => _db.close());
//
//  Future<void> updateCountryStats(AnswerLog newLog) =>
//      _connectSQLite().then((_) => _db.rawUpdate(
//          'UPDATE country SET callcounter = callcounter + 1${newLog.isCorrect ? ', correctcounter = correctcounter + 1' : ''} WHERE ID = ${newLog.question.countryID};'));
//
//  void addLog(AnswerLog newLog) => privateLogs.add(newLog);
//
//  void saveLogs() {
//    if (privateLogs.length == 0) return;
//    var incrementCallCounterQuery = '''
//    UPDATE country
//    SET callcounter = callcounter + 1
//    WHERE ID IN (''';
//    var isAtLeastOneCorrect = false;
//    var incrementCorrectCounterQuery = '''
//    UPDATE country
//    SET correctcounter = correctcounter + 1
//    WHERE ID IN (''';
//    // var insertQuery = '''
//    //     INSERT INTO answerlog(questionID, answerID, isCorrect, logTime, answerTime)
//    //     VALUES ''';
//    for (var index = 0; index < privateLogs.length; index++) {
//      // update query process
//      incrementCallCounterQuery += '${privateLogs[index].question.countryID},';
//      // incrementCallCounterQuery += index == privateLogs.length - 1 ? ');' : ',';
//      if (privateLogs[index].isCorrect) {
//        incrementCorrectCounterQuery +=
//        '${privateLogs[index].question.countryID},';
//        // incrementCorrectCounterQuery +=
//        //     index == privateLogs.length - 1 ? ');' : ',';
//        isAtLeastOneCorrect = true;
//      }
//      // insert query process
//      // insertQuery +=
//      //     '(${privateLogs[index].question.countryID}, ${privateLogs[index].answer.countryID}, ${privateLogs[index].isCorrect ? 1 : 0}, \'${DateTime.now().toString()}\', ${privateLogs[index].answerTime})';
//      // insertQuery += index == privateLogs.length - 1 ? ';' : ', ';
//    }
//    privateLogs.clear();
//    // try {
//    incrementCallCounterQuery = incrementCallCounterQuery.substring(
//        0, incrementCallCounterQuery.length - 1) +
//        ');';
//    if (isAtLeastOneCorrect) {
//      incrementCorrectCounterQuery = incrementCorrectCounterQuery.substring(
//          0, incrementCorrectCounterQuery.length - 1) +
//          ');';
//      _connectSQLite()
//          .then((_) => _db.rawUpdate(incrementCallCounterQuery))
//          .then((_) => print('Update callcounter successfully'))
//          .then((_) => _db.rawUpdate(incrementCorrectCounterQuery))
//          .then((_) => print('Update correctcounter callcounter successfully'))
//      // .then((_) => _db.close())
//      // .then((_) => _db.rawInsert(insertQuery))
//      // .then((_) => print('Insert successfully'))
//          .catchError((error) => print(error));
//    } else {
//      _connectSQLite()
//          .then((_) => _db.rawUpdate(incrementCallCounterQuery))
//          .then((_) => print('Update callcounter successfully'))
//      // .then((_) => _db.close())
//      // .then((_) => _db.rawInsert(insertQuery))
//      // .then((_) => print('Insert successfully'))
//          .catchError((error) => print(error));
//    }
//    // } catch (_) {
//    //   print(
//    //       'I know this bug. Which occured when player guessed so many flags that caused string overflow.');
//    // }
//  }
//
//  Future<String> readLogs() => _connectSQLite().then((_) => _db.rawQuery('''
//          SELECT *
//          FROM answerlog
//          ''')).then((maps) {
//    // print('There are ${maps.length} answerlogs.');
//    String logsString = '';
//    int counter = 1;
//    for (var map in maps) {
//      logsString += '''
//              $counter >>>>>>>>>>>>>>>>>>>>>>
//              {
//                qID: ${map['questionID']},
//                aID: ${map['answerID']},
//                isCorrect: ${map['isCorrect']},
//                logTime: ${map['logTime']},
//                answerTime: ${map['answerTime']}
//              }
//              ''';
//      counter++;
//    }
//    return logsString;
//  });
//
//  Future<void> deleteLogs() => _connectSQLite()
//      .then((_) => _db.rawDelete('DELETE FROM answerlog'))
//  // .then((_) => _db.close())
//      .then((_) => print('Logs deleted successfully.'));
//}
