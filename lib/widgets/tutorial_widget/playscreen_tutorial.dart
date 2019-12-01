import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/widgets/play_screen_drawer.dart';
import 'package:flaguru/widgets/tutorial_widget/playscreen_widget/round_area_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase_widget.dart';

class PlayTutorial extends StatefulWidget {
  @override
  _PlayTutorialState createState() => _PlayTutorialState();
}

class _PlayTutorialState extends State<PlayTutorial> {
 
  Difficulty diff = Difficulty.EASY;
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ShowCaseWidget(builder: Builder(builder: (context) => PlayScreenTutorial( difficulty : diff),),),
    );
  }
}

class PlayScreenTutorial extends StatefulWidget {
   final Difficulty difficulty;
  const PlayScreenTutorial({this.difficulty});
  
  @override
  _PlayScreenTutorialState createState() => _PlayScreenTutorialState();
}

class _PlayScreenTutorialState extends State<PlayScreenTutorial> {
   List<GlobalKey> listkey = List<GlobalKey>(6);
   @override
  void initState() {
    for (var i = 0; i< listkey.length; i++)
    {
      listkey[i] = GlobalKey();
    }
  
    delayShowCase();
    super.initState();
  }
  void delayShowCase ()
  {
    Future.delayed(Duration(milliseconds: 500), ()=> WidgetsBinding.instance.addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase(listkey)));
  }
  @override
  Widget build(BuildContext context) {
    //delayShowCase();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff019dad),
        drawer: PlayScreenDrawer(widget.difficulty),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            children: <Widget>[
              //TopBar(widget.difficulty),
              Container(height: 55,),
              Expanded(child: RoundAreaTutorial(widget.difficulty, listkey)),
            ],
          ),
        ),
      ),
    );
  }
}


