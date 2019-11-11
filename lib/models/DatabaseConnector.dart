import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnector {
  Database _db;
  var privateLogs = List<AnswerLog>();

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
    if (this._db == null || !_db.isOpen) this._db = await openDatabase(path);
  }

  Future<List<Country>> collectCountries({count: 0}) async {
    await _connectSQLite();
    var maps = List<Map>();
    maps = await this._db.rawQuery('''
    SELECT * 
    FROM country
    ''');
    // for (var item in maps) print(item.keys);
    var countries = List.generate(
        maps.length,
        (i) => Country(
              id: maps[i]['ID'],
              name: maps[i]['name'],
              flag: maps[i]['flag'],
              callCounter: maps[i]['callcounter'],
              correctCounter: maps[i]['correctcounter'],
              description: maps[i]['description'],
              chances: maps[i]['chances'],
            ));
    // sort countries.
    for (var leftCursor = 0; leftCursor < countries.length - 1; leftCursor++) {
      for (var rightCursor = countries.length - 1;
          rightCursor > leftCursor;
          rightCursor--) {
        if (countries[rightCursor - 1].ratio > countries[rightCursor].ratio) {
          var temp = countries[rightCursor - 1];
          countries[rightCursor - 1] = countries[rightCursor];
          countries[rightCursor] = temp;
        }
      }
    }
    // await _db.close();
    return countries;
  }

  Future<void> updateChances({@required int countryID, int chances}) =>
      this._connectSQLite().then((_) => this._db.rawUpdate('''
          UPDATE country 
          SET chances = $chances 
          WHERE ID = $countryID
          '''));

  Future<void> updateCountryStats(AnswerLog newLog) =>
      _connectSQLite().then((_) => _db.rawUpdate(
          'UPDATE country SET callcounter = callcounter + 1${newLog.isCorrect ? ', correctcounter = correctcounter + 1' : ''} WHERE ID = ${newLog.question.countryID};'));

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
    var insertQuery = '''
        INSERT INTO answerlog(questionID, answerID, isCorrect, logTime, answerTime)
        VALUES ''';
    for (var index = 0; index < privateLogs.length; index++) {
      // update query process
      incrementCallCounterQuery += '${privateLogs[index].question.countryID}';
      incrementCallCounterQuery += index == privateLogs.length - 1 ? ');' : ',';
      if (privateLogs[index].isCorrect) {
        incrementCorrectCounterQuery +=
            '${privateLogs[index].question.countryID}';
        incrementCorrectCounterQuery +=
            index == privateLogs.length - 1 ? ');' : ',';
        isAtLeastOneCorrect = true;
      }
      // insert query process
      insertQuery +=
          '(${privateLogs[index].question.countryID}, ${privateLogs[index].answer.countryID}, ${privateLogs[index].isCorrect ? 1 : 0}, \'${DateTime.now().toString()}\', ${privateLogs[index].answerTime})';
      insertQuery += index == privateLogs.length - 1 ? ';' : ', ';
    }
    privateLogs.clear();
    if (isAtLeastOneCorrect) {
      _connectSQLite()
          .then((_) => _db.rawUpdate(incrementCallCounterQuery))
          .then((_) => print('Update callcounter successfully'))
          .then((_) => _db.rawUpdate(incrementCorrectCounterQuery))
          .then((_) => print('Update correctcounter callcounter successfully'))
          .then((_) => _db.rawInsert(insertQuery))
          .then((_) => print('Insert successfully'))
          .catchError((error) => print(error));
    } else {
      _connectSQLite()
          .then((_) => _db.rawUpdate(incrementCallCounterQuery))
          .then((_) => print('Update callcounter successfully'))
          .then((_) => _db.rawInsert(insertQuery))
          .then((_) => print('Insert successfully'))
          .catchError((error) => print(error));
    }
  }

  // void saveLogs() {
  //   if (privateLogs.length == 0) return;
  //   var updateQuery = '';
  //   var insertQuery = '''
  //       INSERT INTO answerlog(questionID, answerID, isCorrect, logTime, answerTime)
  //       VALUES ''';
  //   for (var index = 0; index < privateLogs.length; index++) {
  //     updateQuery += 'UPDATE country SET callcounter = callcounter + 1';
  //     updateQuery += privateLogs[index].isCorrect
  //         ? ', correctcounter = correctcounter + 1 WHERE ID = ${privateLogs[index].question.countryID};'
  //         : ' WHERE ID = ${privateLogs[index].question.countryID};';
  //     // print(updateQuery + '\n');
  //     insertQuery +=
  //         '(${privateLogs[index].question.countryID}, ${privateLogs[index].answer.countryID}, ${privateLogs[index].isCorrect ? 1 : 0}, \'${DateTime.now().toString()}\', ${privateLogs[index].answerTime})';
  //     insertQuery += index == privateLogs.length - 1 ? ';' : ', ';
  //   }
  //   privateLogs.clear();
  //   _connectSQLite()
  //       .then((_) => _db.execute(updateQuery))
  //       .then((_) => print('Update successfully'))
  //       .then((_) => _db.rawInsert(insertQuery))
  //       .then((_) => print('Insert successfully'))
  //       .catchError((error) => print(error));
  // }

  Future<String> readLogs() => _connectSQLite().then((_) => _db.rawQuery('''
          SELECT *
          FROM answerlog
          ''')).then((maps) {
        print('There are ${maps.length} answerlogs.');
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

  Future<void> deleteLogs() => _connectSQLite()
      .then((_) => _db.rawDelete('DELETE FROM answerlog'))
      // .then((_) => _db.close())
      .then((_) => print('Logs deleted successfully.'));
}
