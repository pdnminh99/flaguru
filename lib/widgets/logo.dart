import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color color = Colors.white.withOpacity(0.9);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;

        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'FLAG',
                style: TextStyle(
                    color: color, fontWeight: FontWeight.bold, fontSize: height * 0.7, height: 1),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset('assets/images/logo/waving-flag-long.gif',
                      height: height * 0.21, fit: BoxFit.fitWidth),
                  Text(
                    'URU',
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: height * 0.4,
                        height: 1),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
