import 'package:flutter/material.dart';

import '../models/Rule.dart';
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
      style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold),
    );
  }

  buildStartButton(Animation<double> animation, BuildContext context) {
    return Container(
      width: animation.value * 80,
      height: animation.value * 50,
      child: RaisedButton(
        elevation: 5,
        color: getColor(diff),
        onPressed: () => toPlayScreen(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        child: Icon(Icons.play_arrow, size: animation.value * 35, color: Colors.white),
      ),
    );
  }

  Widget buildExpandableArea(AnimationController controller, BuildContext context) {
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
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: buildDiffInfoArea(context),
        ),
      ),
    );
  }

  Widget buildDiffInfoArea(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getSentenceWidget(diff),
    );
  }

  Color getColor(Difficulty diff) {
    switch (diff) {
      case Difficulty.EASY:
        return Colors.green[600];
      case Difficulty.NORMAL:
        return const Color(0xff019dad);
      case Difficulty.HARD:
        return Colors.red[600];
      case Difficulty.ENDLESS:
        return Colors.indigo;
      default:
        return Colors.black;
    }
  }

  List<Widget> getSentenceWidget(Difficulty diff) {
    final List<Widget> list = [];

    for (var sen in getSentences(diff)) {
      var parts = sen.split('`');
      if (parts.length == 1)
        list.add(Text(parts[0], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
      else {
        list.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(parts[0], style: TextStyle(fontSize: 17)),
            const SizedBox(width: 10),
            Text(parts[1], style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
          ],
        ));
      }
    }

    return list;
  }

  List<String> getSentences(Difficulty diff) {
    final rule = Rule(diff);
    final quizTotal = diff == Difficulty.ENDLESS ? '--' : rule.quizTotal;
    final sentences = [
      'Total of Quizzes`$quizTotal',
      'Total of Lives`${rule.maxLife}',
      'Seconds per Quiz`${rule.timeLimit}',
    ];
    if (diff == Difficulty.ENDLESS) sentences.add('Good luck!');
    return sentences;
  }

  void toPlayScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(PlayScreen.routeName, arguments: diff);
  }
}
