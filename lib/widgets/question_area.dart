import 'package:flaguru/models/Question.dart';
import 'package:flutter/material.dart';

class QuestionArea extends StatelessWidget {
  final bool isName;
  final Question question;

  QuestionArea({
    @required this.isName,
    @required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: Material(
                elevation: 5,
                child: Image.asset(
                  'assets/background/worldmap.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Color(0xff019dad).withOpacity(0.6),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: isName
                    ? Center(
                        child: Text(
                          question.country,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: constraint.maxHeight * 0.22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Material(
                        elevation: 15,
                        borderRadius: BorderRadius.circular(3),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          height: constraint.maxWidth * 0.55 / 1.7,
                          width: constraint.maxWidth * 0.55,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(
                              question.imageURL,
                              fit: BoxFit.cover,
                            ),
                          ),
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
