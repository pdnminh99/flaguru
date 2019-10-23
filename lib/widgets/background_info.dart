import 'package:flaguru/widgets/info_background_paint.dart';
import 'package:flutter/material.dart';

class BackgroundInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      child: Container(
        height: 150.0,
      ),
      painter: MyPaint(),
    );
  }
}
