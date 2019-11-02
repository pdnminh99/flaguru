import 'dart:async';

import 'package:flutter/foundation.dart';

class WatchProvider with ChangeNotifier {
  static final WatchProvider _singleton = WatchProvider._internal();

  factory WatchProvider() => _singleton;

  WatchProvider._internal();

  Timer _timer;
  int _time;

  int get time => _time;

  void periodic(int limit, int sec, Function callback) {
    _time = limit;
    _timer = Timer.periodic(Duration(seconds: sec), (_) {
      _time--;
      notifyListeners();
      callback();
      if (_time == 0) cancel();
    });
  }

  void cancel() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
