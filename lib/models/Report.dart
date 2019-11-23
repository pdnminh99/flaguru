import 'dart:convert';
import 'dart:io';


class Report {
  String user;
  var correctCountriesIDs = List<int>();
  var wrongCountriesIDs = List<int>();

  Report({
    this.user,
    this.correctCountriesIDs,
    this.wrongCountriesIDs,
  });

  String get _platformString {
    if (Platform.isWindows) return 'windows';
    if (Platform.isAndroid) return 'android';
    if (Platform.isIOS) return 'ios';
    if (Platform.isLinux) return 'linux';
    if (Platform.isFuchsia) return 'fuchsia';
    if (Platform.isMacOS) return 'macos';
    return 'not identified';
  }

  String toJSON() => jsonEncode({
        'user': user,
        'correctcounter': correctCountriesIDs,
        'wrongcounter': wrongCountriesIDs,
        'platform': _platformString,
      });

  @override
  String toString() =>
      '{ user: $user, correct: $correctCountriesIDs, wrong $wrongCountriesIDs, platform: $_platformString }';
}
