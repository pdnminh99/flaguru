import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/demo_screen.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/menu_screen.dart';
import 'screens/play_screen.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New name here',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
      ),
      initialRoute: DifficultyScreen.routeName,
      routes: {
        PlayScreen.routeName: (context) => PlayScreen(),
        '/': (context) => MenuScreen(),
        DifficultyScreen.routeName: (context) => DifficultyScreen(),
        '/difficulty_screen':(context) => DifficultyScreen()
      },
    );
  }
}
