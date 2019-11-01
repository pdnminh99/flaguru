import 'package:connectivity/connectivity.dart';

class Connection {
  var subscription;
  void connectivityListen(Function func) {
    print("true");
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        print("No Connection");
        //Do smth here
      } else if (result == ConnectivityResult.wifi) {
        print("Wifi Connected");
        //Do smth here
        func();
      }
    });
  }

  dispose() {
    subscription.cancel();
  }
}
