import 'dart:convert';

class Report {
  String user;
  String name;
  var correctCountriesIDs = List<int>();
  var wrongCountriesIDs = List<int>();

  Report({
    this.user,
    this.name,
    this.correctCountriesIDs,
    this.wrongCountriesIDs,
  });

  String toJSON() => jsonEncode({
        'user': user,
        'name': name,
        'correctcounter': correctCountriesIDs,
        'wrongcounter': wrongCountriesIDs,
      });

  @override
  String toString() =>
      '{ user: $user, correct: $correctCountriesIDs, wrong $wrongCountriesIDs }';
}
