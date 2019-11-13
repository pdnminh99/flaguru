import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flaguru/utils/enum_string.dart';
import 'package:flaguru/widgets/start_button_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableDiffCard extends AnimatedWidget {
  final Difficulty diff;
  final Function onTap;

  ExpandableDiffCard(AnimationController controller, {this.diff, this.onTap})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Material(
        elevation: 10,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Column(
            children: <Widget>[
              buildHeader(EnumString.getDifficulty(diff)),
              buildExpandableArea(listenable, context),
              buildBestResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Text(
        header.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
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
      child: SingleChildScrollView(child: buildDiffInfoArea(context)),
    );
  }

  Widget buildBestResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.check_circle, color: Colors.black54),
          Icon(Icons.functions, color: Colors.black54),
        ],
      ),
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
          AnimatedStartButton(95, 55, Colors.white, () => toPlayScreen(context)),
        ],
      ),
    );
  }

  void toPlayScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(PlayScreen.routeName, arguments: diff);
  }

  List<String> getSentences() {}
}
