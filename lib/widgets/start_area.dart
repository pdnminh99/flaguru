import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/global_audio_player.dart';
import '../utils/round_provider.dart';

class StartArea extends StatefulWidget {
  @override
  _StartAreaState createState() => _StartAreaState();
}

class _StartAreaState extends State<StartArea> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Timer timer;

  @override
  void initState() {
    audioPlayer.playSoundLetsGo();
    controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    controller.forward();

    setTimer();
    super.initState();
  }

  void setTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      controller.value = 0;
      controller.forward();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);

    return Center(
      child: AnimatedBuilder(
        animation: controller,
        child: Container(
          width: 95,
          height: 55,
          child: RaisedButton(
            color: Colors.white,
            elevation: 10,
            onPressed: round.startGame,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.play_arrow, size: 35),
          ),
        ),
        builder: (BuildContext context, Widget child) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.rotationX(controller.value * pi),
            child: child,
          );
        },
      ),
    );
  }
}
