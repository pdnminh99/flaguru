import 'dart:async';
import 'package:flutter/material.dart';

import '../widgets/diff_card_expandable.dart';
import '../models/Enum.dart';
import 'menu_screen.dart';

class DifficultyScreen extends StatefulWidget {
  static final routeName = '/difficulty_screen';
  final Difficulty diff;

  DifficultyScreen({this.diff = Difficulty.EASY});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> with TickerProviderStateMixin {
  final controllers = List<AnimationController>(4);

  Timer timer;

  @override
  void initState() {
    for (var i = 0, len = controllers.length; i < len; i++) {
      controllers[i] =
          AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    }

    setTimer();
    super.initState();
  }

  void setTimer() {
    timer =
        Timer(const Duration(milliseconds: 300), () => controllers[widget.diff.index].forward());
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var ctr in controllers) ctr.dispose();
    super.dispose();
  }

  void animate(int index) {
    for (var i = 0, len = controllers.length; i < len; i++) {
      final ctr = controllers[i];
      if (i == index) {
        (ctr.value == 1) ? ctr.reverse() : ctr.forward();
      } else
        ctr.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff019dad),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildHeader(context),
                ExpandableDiffCard(controllers[0], diff: Difficulty.EASY, onTap: () => animate(0)),
                ExpandableDiffCard(controllers[1],
                    diff: Difficulty.NORMAL, onTap: () => animate(1)),
                ExpandableDiffCard(controllers[2], diff: Difficulty.HARD, onTap: () => animate(2)),
                ExpandableDiffCard(controllers[3],
                    diff: Difficulty.ENDLESS, onTap: () => animate(3)),
              ],
            ),
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
            onPressed: () => Navigator.of(context).pushReplacementNamed(MenuScreen.routeName),
          ),
          Text(
            'Difficulty',
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
