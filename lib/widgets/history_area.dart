import 'dart:math';

import 'package:flaguru/models/AnswerLog.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/widgets/history_area_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryArea extends StatefulWidget {
  final double btnHeight;
  final Result result;

  HistoryArea({
    @required this.result,
    @required this.btnHeight,
  });

  @override
  _HistoryAreaState createState() => _HistoryAreaState();
}

class _HistoryAreaState extends State<HistoryArea>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  HistoryAreaAnimation animation;
  bool isUp = false;

  final padding = 12.0;
  final tileHeight = 50.0;

  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = HistoryAreaAnimation(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heightArea = MediaQuery.of(context).size.height * 0.8;
    final widthArea = MediaQuery.of(context).size.width * 0.8;

    final transparent = widget.result.answerLogs.length * tileHeight >
        heightArea - widget.btnHeight - padding;

    final radius = 10.0;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widthArea,
          height: widget.btnHeight +
              animation.listAnim.value * (heightArea - widget.btnHeight),
          margin: EdgeInsets.only(
            bottom: animation.bottomMarginAnim.value * heightArea * 1.25 * 0.1,
          ),
          decoration: BoxDecoration(
            color: animation.colorAnim.value,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
              bottomLeft: Radius.circular(animation.listAnim.value * radius),
              bottomRight: Radius.circular(animation.listAnim.value * radius),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 5),
            ],
          ),
          child: Stack(
            children: <Widget>[
              buildListView(
                  widget.result.answerLogs, widthArea, heightArea, animation),
              Positioned(
                bottom: 0,
                child: buildBackButton(transparent, widthArea, widget.btnHeight,
                    animation.btnAnim),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildListView(List<AnswerLog> logs, double width, double height,
      HistoryAreaAnimation animation) {
    return FadeTransition(
      opacity: animation.contentShowingAnim,
      child: Container(
        height: animation.listAnim.value * height,
        width: double.infinity,
        child: ListView.builder(
          itemCount: logs.length,
          itemBuilder: (BuildContext context, int index) {
            return buildListTile(index, logs[index], tileHeight);
          },
        ),
      ),
    );
  }

  Widget buildListTile(int index, AnswerLog log, double height) {
    final padding = 9.0;
    final realHeight = height - padding * 2;
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
              radius: realHeight * 0.35,
              backgroundColor:
                  log.isCorrect ? Colors.green[600] : Colors.red[600],
              child: Icon(
                log.isCorrect ? Icons.done : Icons.clear,
                size: realHeight * 0.5,
                color: Colors.white,
              )),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                (index + 1).toString() + '. ' + log.question.country,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: realHeight * 0.45,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Material(
            elevation: 5,
            child: Image.asset(log.question.imageURL,
                height: realHeight * 0.8, width: realHeight * 0.8 * 1.7),
          ),
        ],
      ),
    );
  }

  Widget buildBackButton(bool transparent, double width, double height,
      Animation<double> animation) {
    return GestureDetector(
      onTap: () {
        isUp ? _controller.reverse() : _controller.forward();
        isUp = !isUp;
      },
      child: Container(
        width: width - animation.value * padding * 2,
        height: height,
        margin: EdgeInsets.all(animation.value * padding),
        decoration: BoxDecoration(
          color:
              transparent ? const Color(0x3324b6c5) : const Color(0xcc24b6c5),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(animation.value * 8),
            bottomRight: Radius.circular(animation.value * 8),
          ),
        ),
        child: Transform.rotate(
          angle: animation.value * pi,
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white.withOpacity(0.9),
            size: height * 0.8,
          ),
        ),
      ),
    );
  }
}
