import 'dart:async';

import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  final Function onStart;

  StartButton({
    @required this.onStart,
  });

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  double height = 80;
  double width = 150;
  bool isBig = false;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (_) {
      setState(() {
        height = (isBig) ? height - 5 : height + 5;
        width = (isBig) ? width - 10 : width + 10;
        isBig = !isBig;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        height: height,
        width: width,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return RaisedButton(
              elevation: 5,
              color: Colors.white,
              onPressed: widget.onStart,
              child: Text(
                'START',
                style: TextStyle(
                  fontSize: constraint.maxWidth * 0.17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(constraint.maxWidth * 0.1),
              ),
            );
          },
        ),
      ),
    );
  }
}
