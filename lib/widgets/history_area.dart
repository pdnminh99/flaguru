import 'package:flutter/material.dart';

class HistoryArea extends AnimatedWidget {
  final double initHeight;

  HistoryArea({this.initHeight, Animation<double> controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: initHeight,
      color: Colors.green.withOpacity(0.5),
    );
  }
}
