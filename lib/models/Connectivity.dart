import 'package:connectivity/connectivity.dart';
import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flaguru/models/HttpProvider.dart';
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
    print(logsResult.toString());
    return logsResult;
  }

  static Future<bool> _clearLocalLogs() async =>
      await (await DatabaseConnector.getInstance()).clearLogs();

  static void createNetworkListener() {
    var listener = Connectivity()
      ..onConnectivityChanged.listen((ConnectivityResult status) {
        if (status == ConnectivityResult.none)
          print('>>>> NETWORK DISCONNECTED <<<<<');
        else {
          print(status == ConnectivityResult.mobile
              ? '>>>> MOBILE NETWORK DETECTED <<<<'
              : '>>>> WIFI NETWORK DETECTED <<<<');
          _summarizeReportFromSQLite().then((Report logsResult) {
            var httpProvider = HttpProvider();
            return httpProvider.sendReports(logsResult);
          }).then((bool isSuccess) {
            if (isSuccess) {
              print(
                  'Local logs are sent to the cloud. Attempting to remove local storage.');
              return _clearLocalLogs();
            }
            return false;
          }).catchError((error) => print(error));
        }
      });
  }

  static Future<void> checkUpdates() async {
    var databaseInstance = await DatabaseConnector.getInstance();
  }
}
