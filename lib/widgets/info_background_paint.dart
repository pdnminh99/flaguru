import 'package:flutter/material.dart';

class CustomPaintBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.fromRGBO(34, 182, 192, 1)
      ..style = PaintingStyle.fill;
      //..strokeWidth = 8.0;

    Path path = Path();
    path.moveTo(0, size.height * 0.7);
    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 1, size.width, size.height * 0.7);
    path.lineTo(size.width, 0);
    //print(size.width);
    path.lineTo(0, 0);
    path.close();
    canvas.drawShadow(path, Color.fromRGBO(34, 182, 192, 1), 4.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
