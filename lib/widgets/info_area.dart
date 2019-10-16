import 'dart:async';

import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';

class InfoArea extends StatefulWidget {
  final Question question;
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

  @override
  void initState() {
    Timer(Duration(milliseconds: widget.millis), () {
      setState(() => description = widget.question.description +
          ' Flutter is a dream of every mobile developer.');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        num fontSize = constraint.maxHeight * 0.1;
        if (widget.question.country.length > 20)
          fontSize *= 0.6;
        else if (widget.question.country.length > 15) fontSize *= 0.7;
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Material(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        width: constraint.maxHeight * 0.3,
                        height: constraint.maxHeight * 0.3 / 1.7,
                        child: Image.asset(
                          widget.question.imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: constraint.maxHeight * 0.3 / 1.7,
                    child: Center(
                      child: Text(
                        widget.question.country,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: constraint.maxWidth * 0.05,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        );
      },
    );
  }
}
