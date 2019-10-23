import 'dart:async';

import 'package:flaguru/models/Answer.dart';
import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InfoArea extends StatefulWidget {
  final Question question;

//  final QuestionUI question;
  final int millis;

  InfoArea({
    @required this.question,
    @required this.millis,
  });

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
        num fontSize = constraint.maxHeight * 0.1;
        if (widget.question.country.length >= 20)
          fontSize *= 0.6;
        else if (widget.question.country.length >= 14)
          fontSize *= 0.7;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.5),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                spreadRadius: 2)
                          ]),
                      width: constraint.maxHeight * 0.3,
                      height: constraint.maxHeight * 0.3 / 1.7,
                      child: Image.asset(
                        widget.question.imageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: constraint.maxHeight * 0.3 / 1.7,
                    constraints: BoxConstraints(
                      maxWidth: constraint.maxWidth * 0.6,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          widget.question.country,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 15, left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: constraint.maxHeight * 0.064,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
