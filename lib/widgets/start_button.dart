import 'package:flaguru/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StartButton extends StatefulWidget {
  final Function onStart;

  StartButton({@required this.onStart});

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  bool isPressed = false;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = Tween(begin: 0.0, end: 15.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              controller.reverse();
            else if (status == AnimationStatus.dismissed) controller.forward();
          });

    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isPressed)
      return SpinKitCubeGrid(
        color: Colors.white,
        size: 50,
      );
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Container(
            width: 90.0 + animation.value,
            height: 50.0 + animation.value,
            child: RaisedButton(
              color: Colors.white,
              elevation: 10,
              onPressed: () {
                setState(() => isPressed = true);
                widget.onStart();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.play_arrow, size: 30 + animation.value),
            ),
          );
        },
      ),
    );
  }
}
