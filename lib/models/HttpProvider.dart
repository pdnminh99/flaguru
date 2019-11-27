import 'dart:convert';

import 'package:flaguru/models/Country.dart';
import 'package:http/http.dart';
import 'package:flaguru/models/Report.dart';

class HttpProvider {
  final _reportURL =
      'https://us-central1-flaguru-35568.cloudfunctions.net/handleReport';
  final _updateURL =
      'https://us-central1-flaguru-35568.cloudfunctions.net/queryNewUpdates';

  Future<bool> sendReports(Report reportLogs) async => reportLogs == null
      ? false
      : (await post(_reportURL,
                  headers: {"Content-type": "application/json"},
                  body: reportLogs.toJSON()))
              .statusCode ==
          200;

  Future<List<Country>> getUpdates(int recentUpdateDates, String userID, String name) async {
    var response = recentUpdateDates == null
        ? (await get('$_updateURL?user=$userID&name=$name'))
        : (await get('$_updateURL?date=$recentUpdateDates&user=$userID&name=$name'));
    if (response.statusCode != 200) return List<Country>();
    var countries = List<Country>();
    jsonDecode(response.body).forEach((country) {
      countries.add(Country(
          id: country["id"],
          chances: 0,
          name: country['name'],
          correctCounter: country['correctcounter'],
          callCounter: country['callcounter']));
    });
    return countries;
  }
}
