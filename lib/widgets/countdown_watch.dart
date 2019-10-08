import 'package:flutter/material.dart';

class CountdownWatch extends StatelessWidget {
  final num time;

  bool get isLastSeconds => time <= 5;

  CountdownWatch({@required this.time});

  @override
  Widget build(BuildContext context) {
    Color color = isLastSeconds ? Colors.red[700] : Colors.black;

    return LayoutBuilder(
      builder: (context, constraint) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: <Widget>[
              if (isLastSeconds)
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: constraint.maxWidth / 2.8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    time.toString(),
                    style: TextStyle(
                      fontSize: constraint.maxHeight * 0.65,
                      color: color,
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.access_alarm,
                    size: constraint.maxHeight * 0.55,
                    color: color,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
