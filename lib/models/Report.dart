import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Report {
  String user;
  var correctCountriesIDs = List<int>();
  var wrongCountriesIDs = List<int>();
  DateTime generatedTime;

  Report(
      {@required this.user,
      @required this.correctCountriesIDs,
      @required this.wrongCountriesIDs}) {
    this.generatedTime = DateTime.now();
  }

  String toJSON() => jsonEncode({
        'user': user,
        'correctcounter': correctCountriesIDs,
        'wrongcounter': wrongCountriesIDs,
      });

  // String toJSON() =>
  //     '{ "user": "$user", "correccounter": ${correctCountriesIDs.toString()}, "wrongcounter": ${wrongCountriesIDs.toString()} }';

  @override
  String toString() =>
      '{ user: $user, correct: $correctCountriesIDs, wrong $wrongCountriesIDs, time: $generatedTime }';
}
