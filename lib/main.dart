import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/SettingsHandler.dart';
import 'screens/info_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/play_screen.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MyApp(await SettingsHandler.getInstance()));
}

// class MyApp extends StatefulWidget {
//   @override
//   DemoScreen createState() => DemoScreen();
// }

class MyApp extends StatelessWidget {
  final SettingsHandler settings;

  MyApp(this.settings);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => settings,
      child: MaterialApp(
        title: 'Flaguru',
        theme: ThemeData(fontFamily: 'Quicksand'),
        initialRoute: MenuScreen.routeName,
        routes: {
          '/': (context) => MenuScreen(),
          MenuScreen.routeName: (context) => MenuScreen(),
          DifficultyScreen.routeName: (context) => DifficultyScreen(),
          PlayScreen.routeName: (context) => PlayScreen(ModalRoute.of(context).settings.arguments),
          InfoScreen.routeName: (context) => InfoScreen(),
        },
      ),
    );
  }
}
