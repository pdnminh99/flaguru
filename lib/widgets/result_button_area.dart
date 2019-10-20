import 'package:flutter/material.dart';

class ResultButtonArea extends StatefulWidget {
  @override
  _ResultButtonAreaState createState() => _ResultButtonAreaState();
}

class _ResultButtonAreaState extends State<ResultButtonArea>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: Colors.green.withOpacity(0.5),
        );
      },
    );
  }
}
