import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountdownWatch extends StatelessWidget {
  final num time;
  final num redTime;

  CountdownWatch({
    @required this.time,
    @required this.redTime,
  });

  bool get isLastSeconds => time < redTime;

  @override
  Widget build(BuildContext context) {
    Color color = isLastSeconds ? Colors.red[700] : Colors.black;

    return LayoutBuilder(
      builder: (context, constraint) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: constraint.maxWidth / 2.7,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: (isLastSeconds) ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: (time.toString().length > 1)
                          ? constraint.maxWidth * 0.14
                          : constraint.maxWidth * 0.07,
                      child: Text(
                        time.toString(),
                        style: TextStyle(
                          fontSize: constraint.maxHeight * 0.65,
                          color: color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SpinKitChasingDots(
                      color: color,
                      size: constraint.maxHeight * 0.4,
                      duration: Duration(seconds: 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
