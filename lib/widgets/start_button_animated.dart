import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedStartButton extends StatefulWidget {
  final double width;
  final double height;
  final Function onPress;
  final Color color;

  AnimatedStartButton(this.width, this.height, this.color, this.onPress);

  @override
  _AnimatedStartButtonState createState() => _AnimatedStartButtonState();
}

class _AnimatedStartButtonState extends State<AnimatedStartButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.55, 1)));

    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: RaisedButton(
          color: widget.color,
          elevation: 3,
          onPressed: widget.onPress,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.play_arrow, size: 35, color: Colors.white),
        ),
      ),
      builder: (BuildContext context, Widget child) {
        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.rotationX(animation.value * pi),
          child: child,
        );
      },
    );
  }
}
