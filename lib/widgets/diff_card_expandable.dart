import 'dart:math';

import 'package:flutter/material.dart';

import '../models/Enum.dart';
import '../screens/play_screen.dart';
import '../utils/enum_string.dart';
import 'diff_best_result_row.dart';

class ExpandableDiffCard extends AnimatedWidget {
  final Difficulty diff;
  final Function onTap;

  ExpandableDiffCard(AnimationController controller, {this.diff, this.onTap})
      : super(listenable: controller);

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
              DiffBestResultRow(diff),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(Animation<double> animation, BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(width: 0),
          buildTextContainer(),
          buildStartButton(animation, context),
        ],
      ),
    );
  }

  Widget buildTextContainer() {
    return Text(
      EnumString.getDifficulty(diff).toUpperCase(),
      style: TextStyle(fontSize: 22, color:Colors.black87, fontWeight: FontWeight.bold),
    );
  }

  buildStartButton(Animation<double> animation, BuildContext context) {
    return Container(
      width: animation.value * 80,
      height: animation.value * 50,
      child: RaisedButton(
        elevation: 6,
        color: getColor(diff),
        onPressed: () => toPlayScreen(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Icon(Icons.play_arrow, size: animation.value * 35, color: Colors.white),
      ),
    );
  }

  Widget buildExpandableArea(AnimationController controller, BuildContext context) {
    return Container(
      width: double.infinity,
      height: controller.value * 150,
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: Colors.black38, width: 0.3),
          bottom: BorderSide(color: Colors.black38, width: 0.3),
        ),
      ),
      child: SingleChildScrollView(
          child: buildDiffInfoArea(context), physics: NeverScrollableScrollPhysics()),
    );
  }

  Widget buildDiffInfoArea(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 150),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Quiz total: 20'),
        ],
      ),
    );
  }

  Color getColor(Difficulty diff) {
    switch (diff) {
      case Difficulty.EASY:
        return Colors.green[700];
      case Difficulty.NORMAL:
        return const Color(0xff019dad);
      case Difficulty.HARD:
        return Colors.red[700];
      case Difficulty.ENDLESS:
        return Colors.indigo[700];
      default:
        return Colors.black;
    }
  }

  void toPlayScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(PlayScreen.routeName, arguments: diff);
  }

  List<String> getSentences() {}
}
