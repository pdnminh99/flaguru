import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestion;
  final int maxLives;
  final int remainLives;

  InfoBar({
    @required this.totalQuestions,
    @required this.currentQuestion,
    @required this.maxLives,
    @required this.remainLives,
  });

  Widget getRemainLifeDot(height) {
    var borderRadius = BorderRadius.circular(height / 2);
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Material(
        elevation: 5,
        borderRadius: borderRadius,
        child: Container(
          width: height,
          height: height,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }

  Widget getLostLifeDot(height) {
    var borderRadius = BorderRadius.circular(height / 2);
    return Container(
      margin: const EdgeInsets.all(3),
      width: height,
      height: height,
      decoration: BoxDecoration(
        color: Colors.teal[200].withOpacity(0.7),
        borderRadius: borderRadius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (var i = 0; i < remainLives; i++)
                    getRemainLifeDot(constraint.maxHeight * 0.4),
                  for (var i = 0, left = maxLives - remainLives; i < left; i++)
                    getLostLifeDot(constraint.maxHeight * 0.4),
                ],
              ),
              Text(
                '$currentQuestion of $totalQuestions',
                style: TextStyle(
                  fontSize: constraint.maxHeight * 0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
