import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/info_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/play_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(MyApp());
}

// class MyApp extends StatefulWidget {
//   @override
//   DemoScreen createState() => DemoScreen();
// }

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flaguru',
      theme: ThemeData(fontFamily: 'Quicksand'),
      initialRoute: MenuScreen.routeName,
      routes: {
        '/': (context) => MenuScreen(),
        MenuScreen.routeName: (context) => MenuScreen(),
        DifficultyScreen.routeName: (context) => DifficultyScreen(),
        PlayScreen.routeName: (context) =>
            PlayScreen(ModalRoute.of(context).settings.arguments as Difficulty),
        InfoScreen.routeName: (context) => InfoScreen(),
      },
    );
  }
}
