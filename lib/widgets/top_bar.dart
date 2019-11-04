import 'package:flutter/material.dart';

import '../models/Enum.dart';
import '../utils/enum_string.dart';

class TopBar extends StatelessWidget {
  final Difficulty difficulty;

  TopBar(this.difficulty);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildDifficultyText(),
          buildDrawerButton(context),
        ],
      ),
    );
  }

  Widget buildDifficultyText() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        EnumString.getDifficulty(difficulty),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget buildDrawerButton(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 66,
      child: FlatButton(
        onPressed: () => Scaffold.of(context).openDrawer(),
        child: const Icon(Icons.more_horiz, size: 30, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
