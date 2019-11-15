import 'package:flaguru/models/Enum.dart';
import 'package:flutter/material.dart';

import 'result_area_animation.dart';
import 'result_row.dart';
import '../models/Result.dart';

class ResultArea extends AnimatedWidget {
  final Result result;
  final double bottomMargin;
  ResultAreaAnimation animation;
  final String highestScore;

  ResultArea({
    @required this.result,
    @required this.bottomMargin,
    @required this.highestScore,
    @required Animation<double> controller,
  }) : super(listenable: controller) {
    animation = ResultAreaAnimation(listenable as Animation<double>);
  }

  final rowColor = Colors.white.withOpacity(0.9);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.bgOpacity,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(right: 20, left: 20, bottom: bottomMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: const Color(0xff24b6c5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [const BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 3)]),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight - bottomMargin;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: height * 0.2,
                  child: ResultRow(
                    animation: animation.right,
                    maxNum: result.correctAnswers,
                    icon: Icons.check_circle_outline,
                    leading: 'Right',
                    trailing: (result.level != Difficulty.ENDLESS)
                        ? ' / ' + result.questionsCounter.toString()
                        : '',
                    color: rowColor,
                    fontSize: height * 0.1,
                    getString: (val) => (val as num).toString(),
                  ),
                ),
                Container(
                  height: height * 0.2,
                  child: ResultRow(
                    animation: animation.life,
                    maxNum: result.remainLives,
                    icon: Icons.favorite_border,
                    leading: 'Life',
                    trailing: ' / ' + result.totalLives.toString(),
                    color: rowColor,
                    fontSize: height * 0.1,
                    getString: (val) => (val as num).toString(),
                  ),
                ),
                Container(
                  height: height * 0.2,
                  child: ResultRow(
                    animation: animation.time,
                    maxNum: result.totalTimeElapsed,
                    icon: Icons.access_time,
                    leading: 'Time',
                    color: rowColor,
                    fontSize: height * 0.1,
                    getString: (val) => getTime(val as num),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  alignment: Alignment.center,
                  child: Container(
                    width: animation.bgScore.value * constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(10)),
                    child: ResultRow(
                      animation: animation.score,
                      maxNum: result.score,
                      icon: Icons.functions,
                      leading: 'Score',
                      color: const Color(0xff019dad),
                      fontSize: height * 0.12,
                      getString: (val) => (val as num).toString(),
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: animation.best,
                  child: buildBestRow(height, highestScore),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBestRow(double height, String score) {
    final style = TextStyle(fontSize: height * 0.08, fontWeight: FontWeight.bold, color: rowColor);

    return Container(
      height: height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.star_border, color: rowColor, size: height * 0.09),
              const SizedBox(width: 5),
              Text('Best', style: style),
            ],
          ),
          Text(score, style: style),
        ],
      ),
    );
  }

  String getTime(num time) {
    final m = time ~/ 60;
    final s = time % 60;
    return '${m.toString().padLeft(2, '0')} : ${s.toInt().toString().padLeft(2, '0')}';
  }
}
