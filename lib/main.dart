import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/demo_screen.dart';
import 'screens/info_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/play_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/tutorial_screen.dart';
import 'screens/difficulty_screen.dart';
import 'models/SettingsHandler.dart';
import 'utils/global_audio_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setEnabledSystemUIOverlays([]);

  final settings = await SettingsHandler.getInstance();
  runApp(MyApp(settings));
}

class MyApp extends StatelessWidget {
  final SettingsHandler settings;

  MyApp(this.settings);

  Widget build(BuildContext context) {
    audioPlayer = GlobalAudioPlayer(this.settings);
    audioPlayer.playMusic();

    return ChangeNotifierProvider(
      create: (context) => settings,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flaguru',
        theme: ThemeData(fontFamily: 'Quicksand'),
        initialRoute: MenuScreen.routeName,
        routes: {
          '/': (context) => MenuScreen(),
          MenuScreen.routeName: (context) => MenuScreen(),
          DifficultyScreen.routeName: (context) => DifficultyScreen(),
          PlayScreen.routeName: (context) => PlayScreen(ModalRoute.of(context).settings.arguments),
          InfoScreen.routeName: (context) => InfoScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          DemoScreen.routeName: (context) => DemoScreen(),
          TutorialScreen.routeName: (context) => TutorialScreen(),
        },
      ),
    );
  }
}
