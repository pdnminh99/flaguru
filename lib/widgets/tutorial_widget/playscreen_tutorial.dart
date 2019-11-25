import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/widgets/play_screen_drawer.dart';
import 'package:flaguru/widgets/round_area.dart';
import 'package:flaguru/widgets/top_bar.dart';
import 'package:flaguru/widgets/tutorial_widget/playscreen_widget/round_area_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase_widget.dart';

class PlayTutorial extends StatefulWidget {
  @override
  _PlayTutorialState createState() => _PlayTutorialState();
}

class _PlayTutorialState extends State<PlayTutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(builder: Builder(builder: (context) => PlayScreenTutorial(difficulty: Difficulty.EASY),),),
    );
  }
}

class PlayScreenTutorial extends StatelessWidget {
 static final routeName = '/play_screen';
  final Difficulty difficulty;

  const PlayScreenTutorial({Key key, this.difficulty}) ;

  

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
              Expanded(child: RoundAreaTutorial(difficulty)),
            ],
          ),
        ),
      ),
    );
  }
}