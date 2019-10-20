import 'package:flutter/material.dart';

class ResultArea extends AnimatedWidget {
  final double bottomMargin;

  ResultArea({
    Key key,
    @required Animation<double> animation,
    @required this.bottomMargin,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    Animation<double> bgOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: animation, curve: Interval(0.0, 0.5)));

    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeTransition(
          opacity: bgOpacity,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, bottomMargin),
            decoration: BoxDecoration(
              color: const Color(0xff24b6c5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[],
            ),
          ),
        );
      },
    );
  }
}
