import 'dart:io';
import 'dart:typed_data';

import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/Report.dart';
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

  Future<List<Country>> collectCountries({bool isAllowedOnly: true}) async {
    var countries = List<Country>();
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
          continent: _mapContinent(country['continent'])));
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

  Future<bool> clearLogs() =>
      _db.delete('answerlog').then((_) => true).catchError((_) => false);

  void saveLogs(bool isSaveLogsEnable) {
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
      incrementCallCounterQuery += '${privateLogs[index].question.countryID},';
      if (privateLogs[index].isCorrect) {
        incrementCorrectCounterQuery +=
            '${privateLogs[index].question.countryID},';
        isAtLeastOneCorrect = true;
      }
      // insert query process
      insertQuery +=
          '(${privateLogs[index].question.countryID}, ${privateLogs[index].answer.countryID}, ${privateLogs[index].isCorrect ? 1 : 0}, \'${DateTime.now().toString()}\', ${privateLogs[index].answerTime})';
      insertQuery += index == privateLogs.length - 1 ? ';' : ', ';
    }
    privateLogs.clear();
    incrementCallCounterQuery = incrementCallCounterQuery.substring(
            0, incrementCallCounterQuery.length - 1) +
        ');';
    if (isAtLeastOneCorrect) {
      incrementCorrectCounterQuery = incrementCorrectCounterQuery.substring(
              0, incrementCorrectCounterQuery.length - 1) +
          ');';
      _db
          .rawUpdate(incrementCallCounterQuery)
          .then((_) => _db.rawUpdate(incrementCorrectCounterQuery))
          .then((_) => isSaveLogsEnable ? _db.rawInsert(insertQuery) : null)
          .catchError((error) => print(error));
    } else
      _db
          .rawUpdate(incrementCallCounterQuery)
          .then((_) => isSaveLogsEnable ? _db.rawInsert(insertQuery) : null)
          .catchError((error) => print(error));
  }

  Future<Report> checkResultLogs() {
    return _db
        .query('answerlog', columns: ['questionID', 'isCorrect']).then((logs) {
      if (logs.length == 0) return null;
      var logsReport = Report();
      logsReport.correctCountriesIDs = List<int>();
      logsReport.wrongCountriesIDs = List<int>();
      logsReport.user = '';
      logs.forEach((log) => log['isCorrect'] != 0
          ? logsReport.correctCountriesIDs.add(log['questionID'])
          : logsReport.wrongCountriesIDs.add(log['questionID']));
      return logsReport;
    });
  }

  Future<bool> updateCountries(List<Country> newCountries) async {
    if (newCountries == null || newCountries.length == 0) return false;
    newCountries.forEach((country) {
      _transactionQueue.update(
          'country',
          {
            'callcounter': country.callCounter,
            'correctcounter': country.correctCounter,
          },
          where: 'ID = ?',
          whereArgs: [country.id]);
    });
    await _transactionQueue.commit(noResult: true, continueOnError: true);
    return true;
  }
}
