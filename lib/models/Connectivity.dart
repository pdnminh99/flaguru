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
    var report = _summarizeReports(userID, logs);
    // print('Sending reports of $userID to the cloud.');
    // print(report.toJSON());
    var httpProvider = HttpProvider();
    return await httpProvider.sendReports(report);
  }

  static void createNetworkListener() {
    var listener = Connectivity()
      ..onConnectivityChanged.listen((status) {
        if (status == ConnectivityResult.none)
          print('>>>> NETWORK DISCONNECTED <<<<<');
        else {
          print(status == ConnectivityResult.mobile
              ? '>>>> MOBILE NETWORK DETECTED <<<<'
              : '>>>> WIFI NETWORK DETECTED <<<<');
          DatabaseConnector.getInstance()
              .then((connector) => connector.checkResultLogs())
              .then((_) => print('Local logs are sent to the cloud.'))
              .catchError((error) => print(error));
        }
      });
  }

  static Future<void> checkUpdates() async {
    var databaseInstance = await DatabaseConnector.getInstance();
  }
}
