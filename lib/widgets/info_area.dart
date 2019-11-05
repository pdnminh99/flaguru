import 'dart:async';

import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InfoArea extends StatefulWidget {
  final Question question;
  final int millis;

  InfoArea(this.question, this.millis);

  @override
  _InfoAreaState createState() => _InfoAreaState();
}

class _InfoAreaState extends State<InfoArea> {
  String description = '';
  Timer _timer;

  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: widget.millis), () {
      setState(() => description = widget.question.description);
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
    return LayoutBuilder(
      builder: (context, constraint) {
        final height = constraint.maxHeight;
        final width = constraint.maxWidth;

        return Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                buildTitle(height, width),
                buildDescription(),
              ],
            ),
            Positioned(bottom: 0, child: buildBottomBlur(width))
          ],
        );
      },
    );
  }

  Widget buildTitle(double height, double width) {
    num fontSize = height * 0.08;
    if (widget.question.country.length >= 20)
      fontSize *= 0.7;
    else if (widget.question.country.length >= 14) fontSize *= 0.8;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Material(
              elevation: 5,
              child: Container(
                width: height * 0.3,
                height: height * 0.3 / 1.7,
                decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 0.5)),
                child: Image.asset(widget.question.imageURL, fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: height * 0.3 / 1.7,
            constraints: BoxConstraints(maxWidth: width * 0.6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.question.country,
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (var sentence in getParagraph(description)) ...[
            Text(
              sentence,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildBottomBlur(double width) {
    return Visibility(
      visible: description.isNotEmpty,
      child: Container(
        height: 20,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0x0099d8df), const Color(0xee99d8df)],
          ),
        ),
      ),
    );
  }

  List<String> getParagraph(String raw) {
    final sentences = raw.split('. ');
    final len = sentences.length - 1;
    for (var i = 0; i < len; i++) sentences[i] += '.';
    return sentences;
  }
}
