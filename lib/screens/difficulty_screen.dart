import 'dart:async';
import 'package:flutter/material.dart';

import '../models/Enum.dart';
import 'menu_screen.dart';
import '../widgets/diff_card_expandable.dart';

class DifficultyScreen extends StatefulWidget {
  static String routeName = '/difficulty_screen';
  final Difficulty diff;

  DifficultyScreen({this.diff = Difficulty.NORMAL});

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> with TickerProviderStateMixin {
  final _controllers = List<AnimationController>(4);

  Timer timer;

  @override
  void initState() {
    for (var i = 0, len = _controllers.length; i < len; i++) {
      _controllers[i] =
          AnimationController(duration: const Duration(milliseconds: 350), vsync: this);
    }

    setTimer();
    super.initState();
  }

  void setTimer() {
    timer = Timer(
        const Duration(milliseconds: 250), () => _controllers[getIndex(widget.diff)].forward());
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var controller in _controllers) controller.dispose();
    super.dispose();
  }

  void animate(int index) {
    for (var i = 0, len = _controllers.length; i < len; i++) {
      final ctr = _controllers[i];
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
                ExpandableDiffCard(_controllers[0], diff: Difficulty.EASY, onTap: () => animate(0)),
                ExpandableDiffCard(_controllers[1],
                    diff: Difficulty.NORMAL, onTap: () => animate(1)),
                ExpandableDiffCard(_controllers[2], diff: Difficulty.HARD, onTap: () => animate(2)),
                ExpandableDiffCard(_controllers[3],
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

  int getIndex(Difficulty diff) {
    switch (diff) {
      case Difficulty.EASY:
        return 0;
      case Difficulty.NORMAL:
        return 1;
      case Difficulty.HARD:
        return 2;
      case Difficulty.ENDLESS:
        return 3;
      default:
        return -1;
    }
  }
}
