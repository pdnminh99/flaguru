import 'dart:async';
import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/tutorial_screen.dart';
import 'package:flaguru/widgets/diff_card_expandable.dart';
import 'package:flaguru/widgets/tutorial_widget/difficultyscreen_widget/expandadble_diff_card_tutorial.dart';
import 'package:flaguru/widgets/tutorial_widget/menuscreen_tutorial.dart';
import 'package:flaguru/widgets/tutorial_widget/playscreen_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';



class Difftutorial extends StatefulWidget {
  @override
  _DifftutorialState createState() => _DifftutorialState();
}

class _DifftutorialState extends State<Difftutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        builder: Builder(
          builder: (context) => DifficultyScreenTutorial(),
        ),
      ),
      
    );
  }
}
class DifficultyScreenTutorial extends StatefulWidget {
  
  final Difficulty diff;

  DifficultyScreenTutorial({this.diff = Difficulty.EASY});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreenTutorial>
    with TickerProviderStateMixin {
  final controllers = List<AnimationController>(4);
  final mykey = List<GlobalKey>(5);
  
  Timer timer;
  bool boolbuildshowcase = false;
  @override
  void initState() {
    for (var i = 0; i< mykey.length; i++)
    {
      mykey[i] = GlobalKey();
    }
    for (var i = 0, len = controllers.length; i < len; i++) {
      controllers[i] = AnimationController(
          duration: const Duration(milliseconds: 350), vsync: this);
    }

    //
    controllers[0].addStatusListener((status) => {
          if (status == AnimationStatus.completed)
            {
              setState(() {
                boolbuildshowcase = true;
              })
            }
        });
    //
     WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase(mykey));

    setTimer();
    super.initState();
  }

  void setTimer() {
    timer = Timer(const Duration(milliseconds: 300),
        () => controllers[widget.diff.index].forward());
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var ctr in controllers) ctr.dispose();
    super.dispose();
  }
  void delayShowcase()
  {
    Future.delayed(Duration(milliseconds: 500), (){ 

    });
  }
  void buildSnackBarPressPlayButton(BuildContext context)
  {
    final snackbar = 
   SnackBar(
    content: Text("Please touch play button to continue tutorial",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 17),),
    
  );
  Scaffold.of(context).showSnackBar(snackbar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: const Color(0xff019dad),
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        buildHeader(context),
                        boolbuildshowcase ?  ExpandableDiffCardTutorial(controllers[0], diff: Difficulty.EASY, listkey: mykey,)
                        : ExpandableDiffCard(controllers[0],
                            diff: Difficulty.EASY, onTap: () => {}) 
                           ,
                        ExpandableDiffCard(controllers[1],
                            diff: Difficulty.NORMAL, onTap: ()=>{buildSnackBarPressPlayButton(context)}
                            
                            ),
                        ExpandableDiffCard(controllers[2],
                            diff: Difficulty.HARD, onTap: () => {buildSnackBarPressPlayButton(context)}),
                        ExpandableDiffCard(controllers[3],
                            diff: Difficulty.ENDLESS, onTap: () => {buildSnackBarPressPlayButton(context)}),
                      ],
                    ),
                  ),
                ),
              );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: () => Navigator.pushReplacementNamed(context, TutorialScreen.routeName),
          ),
          Text(
            'Difficulty',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

