import 'package:connectivity/connectivity.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/HttpProvider.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/Report.dart';

class Connection {
  Report _summarizeReports(String userID, String name, List<AnswerLog> logs) {
    var correctCountriesID = List<int>();
    var wrongCountriesID = List<int>();
    logs.forEach((log) => log.isCorrect
        ? correctCountriesID.add(log.question.countryID)
        : wrongCountriesID.add(log.question.countryID));
    return Report(
        correctCountriesIDs: correctCountriesID,
        wrongCountriesIDs: wrongCountriesID,
        name: name,
        user: userID);
  }

  Future<bool> sendReports(List<AnswerLog> logs) async {
    var connectivityInstance = await (Connectivity().checkConnectivity());
    if (connectivityInstance == ConnectivityResult.none) return false;
    var currentUser = await Authentication().getCurrentUser();
    return await HttpProvider().sendReports(_summarizeReports(
        currentUser?.uuid ?? 'guest', currentUser?.name ?? 'unknown', logs));
  }

  static Future<Report> _summarizeReportFromSQLite() async {
    var logsResult =
        await (await DatabaseConnector.getInstance()).checkResultLogs();
    if (logsResult == null) return null;
    var currentUser = await Authentication().getCurrentUser();
    logsResult.user = currentUser?.uuid ?? 'guest';
    logsResult.name = currentUser?.name ?? 'unknown';
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
    var changes = await HttpProvider().getUpdates(lastTimeUpdate,
        currentUser?.uuid ?? 'guest', currentUser?.name ?? 'unknown');
    return await db.updateCountries(changes) &&
        await LocalStorage.updateLastTimeUpdate(timestampNow);
  }
}
