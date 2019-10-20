import 'package:flaguru/screens/result_screen.dart';
import 'package:flaguru/widgets/result_row.dart';
import 'package:flaguru/widgets/result_area_animation.dart';
import 'package:flutter/material.dart';

class ResultArea extends AnimatedWidget {
  final Result result;
  final double bottomMargin;
  ResultAreaAnimation animation;

  ResultArea({
    @required this.result,
    @required this.bottomMargin,
    @required Animation<double> controller,
  }) : super(listenable: controller) {
    animation = ResultAreaAnimation(listenable as Animation<double>);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation.bgOpacity,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(right: 20, left: 20, bottom: bottomMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xff24b6c5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight - bottomMargin;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: height * 0.22,
                  child: ResultRow(
                    animation: animation.right,
                    maxNum: result.right,
                    icon: Icons.check_circle_outline,
                    leading: 'Right',
                    trailing: ' / 20',
                    color: Colors.white.withOpacity(0.8),
                    fontSize: height * 0.1,
                    getString: (val) => (val as num).toString(),
                  ),
                ),
                Container(
                  height: height * 0.22,
                  child: ResultRow(
                    animation: animation.life,
                    maxNum: result.life,
                    icon: Icons.favorite_border,
                    leading: 'Life',
                    trailing: ' / 5',
                    color: Colors.white.withOpacity(0.8),
                    fontSize: height * 0.1,
                    getString: (val) => (val as num).toString(),
                  ),
                ),
                Container(
                  height: height * 0.22,
                  child: ResultRow(
                    animation: animation.time,
                    maxNum: result.time,
                    icon: Icons.access_time,
                    leading: 'Time',
                    color: Colors.white.withOpacity(0.8),
                    fontSize: height * 0.1,
                    getString: (val) => getTime(val as num),
                  ),
                ),
                Container(
                  height: height * 0.34,
                  alignment: Alignment.center,
                  child: Container(
                    width: animation.bgPoint.value * constraints.maxWidth,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: ResultRow(
                      animation: animation.point,
                      maxNum: result.point,
                      icon: Icons.functions,
                      leading: 'Point',
                      color: const Color(0xff019dad),
                      fontSize: 30,
                      getString: (val) => (val as num).toString(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String getTime(num time) {
    var m = time ~/ 60;
    var s = time % 60;
    return '${m.toString().padLeft(2, '0')} : ${s.toInt().toString().padLeft(2, '0')}';
  }
}
