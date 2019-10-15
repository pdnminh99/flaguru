import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';

class InfoArea extends StatelessWidget {
  final Question question;

  InfoArea({
    @required this.question,
  });

  @override
  Widget build(BuildContext context) {
    var tooLong = question.country.length > 15;
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
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
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      width: constraint.maxHeight * 0.3,
                      height: constraint.maxHeight * 0.3 / 1.7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Image.asset(
                          question.imageURL,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: constraint.maxHeight * 0.3 / 1.7,
                    child: Center(
                      child: Text(
                        question.country,
                        style: TextStyle(
                          fontSize: (tooLong)
                              ? constraint.maxHeight * 0.07
                              : constraint.maxHeight * 0.1,
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
                question.description +
                    ' Flutter is a dream of every mobile developer.',
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
