import 'dart:math';

import 'package:flutter/material.dart';

class MenuButton extends AnimatedWidget {
  final Function onPress;
  final String title;
  final IconData leftIcon;
  final String rightIcon;
  final Animation<double> animation;

  MenuButton(
    this.onPress,
    this.leftIcon,
    this.title,
    AnimationController controller, {
    this.rightIcon,
    double begin = 0,
    double end = 1,
  })  : animation = Tween<double>(begin: 0, end: 1)
            .animate(CurvedAnimation(parent: controller, curve: Interval(begin, end))),
        super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: buildButton(context),
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationX(animation.value * pi * 2),
          alignment: FractionalOffset.center,
          child: child,
        );
      },
    );
  }

  Widget buildButton(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 350,
      child: RaisedButton(
        elevation: 10,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: () => title == "Login" ? onPress() : onPress(context),
        color: Colors.white.withOpacity(0.9),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: (title == 'Settings')
                  ? Hero(tag: 'settings', child: Icon(leftIcon, size: 28, color: Colors.black87))
                  : Icon(leftIcon, size: 28, color: Colors.black87),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black87, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: rightIcon == null
                  ? const SizedBox(width: 30)
                  : Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          border: const Border(left: BorderSide(color: Colors.black54, width: 1))),
                      child: Center(
                        child: rightIcon == 'G'
                            ? Padding(
                                padding: const EdgeInsets.all(14),
                                child:
                                    Image.asset("./assets/icon/search.png", fit: BoxFit.scaleDown),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(rightIcon),
                                backgroundColor: Colors.white,
                              ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
