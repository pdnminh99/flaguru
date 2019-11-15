import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/round_provider.dart';

class QuestionArea extends StatefulWidget {
  @override
  _QuestionAreaState createState() => _QuestionAreaState();
}

class _QuestionAreaState extends State<QuestionArea> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final question = round.roundHandler.question;

    var tooLong = question.country.length > 15;
    return LayoutBuilder(
      builder: (context, constraint) {
        return FadeTransition(
          opacity: _controller,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: round.nameOrFlag
                  ? Center(
                      child: Text(
                        question.country,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              (tooLong) ? constraint.maxWidth * 0.09 : constraint.maxWidth * 0.12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(offset: const Offset(2, 2), blurRadius: 3, color: Colors.black),
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
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        height: constraint.maxWidth * 0.55 / 1.7,
                        width: constraint.maxWidth * 0.55,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: Image.asset(question.imageURL, fit: BoxFit.cover),
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
