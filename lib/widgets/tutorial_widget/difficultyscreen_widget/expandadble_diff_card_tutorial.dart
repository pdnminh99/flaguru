import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/widgets/diff_card_expandable.dart';
import 'package:flaguru/widgets/tutorial_widget/difficultyscreen_widget/diff_best_result_row.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import '../playscreen_tutorial.dart';

class ExpandableDiffCardTutorial extends ExpandableDiffCard {
  ExpandableDiffCardTutorial(AnimationController controller,
      {Difficulty diff, Function onTap, this.listkey})
      : super(controller, diff: diff, onTap: onTap);

  final List<GlobalKey> listkey;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final borderRadius = BorderRadius.circular(10);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 8,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Column(
            children: <Widget>[
              buildHeader(animation, context),
              buildExpandableArea(animation, context),
              DiffBestResultRowTutorial(listkey[2], listkey[3]),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildExpandableArea(AnimationController controller, BuildContext context)
  {
    final height = getSentences(diff).length * 35.0 + 15 * 2;
    final side = const BorderSide(color: Colors.black38, width: 0.3);

    return Container(
      width: double.infinity,
      height: controller.value * height,
      decoration: BoxDecoration(
        border: Border(top: side, bottom: side),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: 
        Showcase (
          key: listkey[1],
          title: "Infomation of this level",
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          description :  "Tap anywhere to continue",
          descTextStyle: TextStyle(fontSize: 15),
          child : Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: buildDiffInfoArea(context),
        ),
      ),
    )
    );
  }

  @override
  Widget buildHeader(Animation<double> animation, BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(width: 0),
          Showcase(
            key: listkey[0],
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            title: "Level of difficult",
            descTextStyle: TextStyle(fontSize: 15),
            description: "Touch screen to continue",
           child:  Container(
              width: 90,
              height: 60,
               child : Center(child : buildTextContainer(),)),),
          buildStartButton(animation, context),
        ],
      ),
    );
  }

  @override
  buildStartButton(Animation<double> animation, BuildContext context) {
    // TODO: implement buildStartButton
    return Showcase(
        title: "Let's play! :D",
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        description: "Touch this to play",
        descTextStyle: TextStyle(fontSize: 15),
        key: listkey[4],
        disposeOnTap: true,
        onTargetClick: () => toPlayScreen(context),
        child: Container(
            width: animation.value * 80,
            height: animation.value * 50,
            child: RaisedButton(
              elevation: 5,
              color: getColor(diff),
              onPressed: () => toPlayScreen(context),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              child: Icon(Icons.play_arrow,
                  size: animation.value * 35, color: Colors.white),
            ),
          ),
        );
  }

  @override
  void toPlayScreen(BuildContext context) {
    // TODO: implement toPlayScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PlayTutorial()));
  }
}