import 'package:flutter/material.dart';

class ResultRow extends AnimatedWidget {
  final int maxNum;
  final double fontSize;
  final Color color;
  final IconData icon;

  final String leading;
  final String trailing;
  final Function getString;

  ResultRow({
    @required this.fontSize,
    @required this.color,
    @required this.leading,
    @required this.maxNum,
    @required this.getString,
    @required Animation<double> animation,
    this.trailing = '',
    this.icon,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final controller = listenable as Animation<double>;
    final opacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0, 0.3)));
    final upNumber = Tween(begin: 0.0, end: maxNum)
        .animate(CurvedAnimation(parent: controller, curve: Interval(0.2, 1)));

    final style = TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color);

    return FadeTransition(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: color, size: fontSize + 5),
                const SizedBox(width: 10),
                Text(leading, style: style),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(getString(upNumber.value.toInt()), style: style),
                Text(trailing, style: style),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
