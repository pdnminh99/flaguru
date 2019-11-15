import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/round_provider.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween(begin: pi / 2, end: 0.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isOver = round.isOver;
    final isAnswered = round.isAnswered;

    if (isAnswered)
      _controller.forward();
    else
      _controller.reverse();

    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedBuilder(
              animation: animation,
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: constraint.maxHeight * 0.7,
                    width: constraint.maxWidth * 0.2,
                    child: RaisedButton(
                      elevation: 5,
                      color: Colors.white,
                      onPressed: isOver ? () => round.onOver(context) : round.getNextQuestion,
                      child: Icon(
                        (isOver) ? Icons.airplay : Icons.arrow_forward,
                        size: constraint.maxHeight * 0.55,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Visibility(
                      visible: !isAnswered,
                      child: Positioned.fill(child: Container(color: Colors.transparent))),
                ],
              ),
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationX(animation.value),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
