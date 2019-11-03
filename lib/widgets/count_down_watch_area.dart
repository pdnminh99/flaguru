import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'countdown_watch.dart';
import '../utils/round_provider.dart';

class CountDownWatchArea extends StatelessWidget {
  final int millis;
  final double height;
  final double width;

  CountDownWatchArea({@required this.millis, @required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isAnswered = round.isAnswered;

    return AnimatedContainer(
      width: isAnswered ? width * 0.2 : width,
      height: isAnswered ? height * 0 : height * 0.2,
      duration: Duration(milliseconds: millis),
      child: ChangeNotifierProvider(
        builder: (_) => round.timer,
        child: CountdownWatch(redTime: 10),
      ),
    );
  }
}
