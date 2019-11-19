import 'package:http/http.dart';
import 'package:flaguru/models/Report.dart';

class HttpProvider {
  final _reportURL = '';

  Future<bool> sendReports(Report reportLogs) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String JSONbody = reportLogs.toJSON();
    var response = await post(_reportURL, headers: headers, body: JSONbody);
    print('Sending report to the cloud. Status code ${response.statusCode}');
    return response.statusCode == 200;
  }
}
