import 'dart:math';

import 'package:flutter/material.dart';

import 'Menu_Icon/menu__icon_icons.dart';

class SpinningGear extends StatefulWidget {
  final double size;
  final Color color;

  SpinningGear({this.size, this.color});

  @override
  _SpinningGearState createState() => _SpinningGearState();
}

class _SpinningGearState extends State<SpinningGear> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.3, 1, curve: Curves.easeIn)));

    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: FittedBox(
        child: Icon(Menu_Icon.settings, size: widget.size, color: widget.color),
      ),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationZ(animation.value * pi / 4),
          alignment: FractionalOffset.center,
          child: child,
        );
      },
    );
  }
}
