import 'package:flaguru/models/Answer.dart';
import 'package:flutter/material.dart';

class QuestionArea extends StatelessWidget {
  final bool isName;
  final QuestionUI question;

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
              child: isName
                  ? FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        question.country,
                        style: TextStyle(
                          fontSize: constraint.maxHeight * 0.25,
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
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      height: constraint.maxWidth * 0.6 / 1.7,
                      width: constraint.maxWidth * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          question.imageUrl,
                          fit: BoxFit.cover,
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
