import 'package:flaguru/widgets/info_background_paint.dart';
import 'package:flutter/material.dart';

class BackgroundInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return CustomPaint(
      child: Container(
        height: _height *0.16,
      ),
      painter: CustomPaintBackground(),
    );
  }
}
