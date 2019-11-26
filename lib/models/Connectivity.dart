import 'package:connectivity/connectivity.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/HttpProvider.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/Report.dart';

class Connection {
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

  static Future<void> _executeSendingReportToCloud() {
    return _summarizeReportFromSQLite()
        .then((Report logsResult) => HttpProvider().sendReports(logsResult))
        .then((bool isSuccess) => isSuccess ? _clearLocalLogs() : false);
  }

  static Future<void> _lookForUpdates() {
    return LocalStorage.queryLastTimeUpdates().then((lastTimeUpdate) =>
        lastTimeUpdate == null ||
                DateTime.now()
                        .difference(
                            DateTime.fromMillisecondsSinceEpoch(lastTimeUpdate))
                        .inDays >
                    0
            ? _executeQueryNewChanges(lastTimeUpdate)
            : (() {})());
  }

  static void createNetworkListener() {
    Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult connectionStatus) => connectionStatus !=
                ConnectivityResult.none
            ? Future.wait([_executeSendingReportToCloud(), _lookForUpdates()])
                .catchError((error) => print(error))
            : (() {})());
  }

  static Future<bool> _executeQueryNewChanges(int lastTimeUpdate) async {
    var timestampNow = DateTime.now().millisecondsSinceEpoch;
    var db = await DatabaseConnector.getInstance();
    var currentUser = await Authentication().getCurrentUser();
    var changes = await HttpProvider().getUpdates(
        lastTimeUpdate,
        currentUser == null ? 'guest' : currentUser.uuid,
        currentUser == null ? 'unknown' : currentUser.name);
    return await db.updateCountries(changes) &&
        await LocalStorage.updateLastTimeUpdate(timestampNow);
  }
}
