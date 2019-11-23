import 'package:flaguru/models/Country.dart';
import 'package:http/http.dart';
import 'package:flaguru/models/Report.dart';

class HttpProvider {
  final _reportURL =
      'https://us-central1-flaguru-35568.cloudfunctions.net/handleReport';
  final _updateURL = '';

  Future<bool> sendReports(Report reportLogs) async => reportLogs == null
      ? false
      : (await post(_reportURL,
                  headers: {"Content-type": "application/json"},
                  body: reportLogs.toJSON()))
              .statusCode ==
          200;

  Future<List<Country>> getUpdates(DateTime recentUpdateDates) async {
    if (recentUpdateDates == null) {
      // retrieve all changes.
    }
    //    var response = await get('$_updateURL?date=${recentUpdateDates.toString()}');
    return List<Country>();
  }
}
