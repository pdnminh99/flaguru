import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/utils/round_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoundProvider>(context);
    final round = provider.roundHandler;
    final quizTotal =
        (provider.rule.difficulty == Difficulty.ENDLESS) ? '--' : provider.rule.quizTotal;

    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (var i = 0; i < round.remainLives; i++)
                    getRemainLifeDot(constraint.maxHeight * 0.4),
                  for (var i = 0, left = round.lifeCount - round.remainLives; i < left; i++)
                    getLostLifeDot(constraint.maxHeight * 0.4),
                ],
              ),
              Text(
                '${provider.index + 1} of $quizTotal',
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
}
