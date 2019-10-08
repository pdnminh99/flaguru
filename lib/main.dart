import 'package:flaguru/screens/demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]); // hide status bar
  runApp(MyApp());
}

// uncomment when done
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DemoScreen();
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'New name here',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         accentColor: Colors.amber,
//         canvasColor: Colors.grey[300],
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => MenuScreen(),
//       },
//     );
//   }
// }
