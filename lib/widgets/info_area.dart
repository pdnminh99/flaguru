import 'package:flutter/material.dart';

class InfoArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Material(
                elevation: 5,
                child: Image.asset(
                  'assets/background/worldmap.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Color(0xff019dad).withOpacity(0.6),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream, flutter is a dream.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
//                  textAlign: TextAlign.justify,
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
