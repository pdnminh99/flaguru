import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/HttpProvider.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/Report.dart';

class Connection {
  void connectivityListen(Function func) {
    // print("true");
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        print("No Connection");
        //Do smth here
      } else {
        print("Wifi or mobile Connected");
        //Do smth here
        func();
      }
    }) as Connectivity;
  }

  Report _summarizeReports(String userID, List<AnswerLog> logs) {
    var correctCountriesID = List<int>();
    var wrongCountriesID = List<int>();
    for (var log in logs) {
      if (log.isCorrect)
        correctCountriesID.add(log.question.countryID);
      else
        wrongCountriesID.add(log.question.countryID);
    }
    return Report(
        correctCountriesIDs: correctCountriesID,
        wrongCountriesIDs: wrongCountriesID,
        user: userID);
  }

  Future<bool> sendReports(List<AnswerLog> logs) async {
    var connectivityInstance = await (Connectivity().checkConnectivity());
    if (connectivityInstance == ConnectivityResult.none) return false;
    var auth = Authentication();
    var currentUser = await auth.getCurrentUser();
    var userID = currentUser == null ? 'guest' : currentUser.uuid;
    var httpProvider = HttpProvider();
    return await httpProvider.sendReports(_summarizeReports(userID, logs));
  }

  static Future<Report> _summarizeReportFromSQLite() async {
    var logsResult =
        await (await DatabaseConnector.getInstance()).checkResultLogs();
    if (logsResult == null) return null;
    var auth = Authentication();
    var currentUser = await auth.getCurrentUser();
    logsResult.user = currentUser == null ? 'guest' : currentUser.uuid;
    return logsResult;
  }

  static Future<bool> _clearLocalLogs() async =>
      await (await DatabaseConnector.getInstance()).clearLogs();

  static Future<void> _executeSendingReportToCloud() =>
      _summarizeReportFromSQLite()
          .then((Report logsResult) => HttpProvider().sendReports(logsResult))
          .then((bool isSuccess) => isSuccess ? _clearLocalLogs() : false);

  static Future<void> _lookForUpdates() => LocalStorage.queryLastTimeUpdates()
      .then((lastTimeUpdate) => lastTimeUpdate == null ||
              DateTime.now().difference(lastTimeUpdate).inDays > 0
          ? Future.wait([
              _executeQueryNewChanges(lastTimeUpdate),
              LocalStorage.updateLastTimeUpdate()
            ])
          : (() => print(
              'Haven\'t seen any update status or it is not the right time to update. Ignore the update process.'))())
      .catchError((error) => print(error));

  static void createNetworkListener() {
    Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult connectionStatus) => connectionStatus !=
                ConnectivityResult.none
            ? Future.wait([_lookForUpdates(), _executeSendingReportToCloud()])
                .catchError((error) => print(error))
            : (() => print('>>>> NETWORK DISCONNECTED <<<<<'))());
  }

  static Future<bool> _executeQueryNewChanges(DateTime lastTimeUpdate) async {
    var db = await DatabaseConnector.getInstance();
    var httpProvider = HttpProvider();
    var changes = await httpProvider.getUpdates(lastTimeUpdate);
    return await db.updateCountries(changes);
  }
}
