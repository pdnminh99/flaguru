import 'package:flutter/material.dart';

import '../models/Enum.dart';
import '../widgets/play_screen_drawer.dart';
import '../widgets/round_area.dart';
import '../widgets/top_bar.dart';

class PlayScreen extends StatelessWidget {
  static final routeName = '/play_screen';
  final Difficulty difficulty;

  PlayScreen(this.difficulty);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff019dad),
        drawer: PlayScreenDrawer(difficulty),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            children: <Widget>[
              TopBar(difficulty),
              Expanded(child: RoundArea(difficulty)),
            ],
          ),
        ),
      ),
    );
  }
}
