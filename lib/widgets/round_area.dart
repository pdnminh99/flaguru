import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Enum.dart';
import '../utils/round_provider.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/play_area.dart';
import '../widgets/start_area.dart';

class RoundArea extends StatefulWidget {
  final Difficulty difficulty;

  RoundArea(this.difficulty);

  @override
  _RoundAreaState createState() => _RoundAreaState();
}

class _RoundAreaState extends State<RoundArea> {
  RoundProvider round;

  @override
  void initState() {
    round = RoundProvider(widget.difficulty);
    super.initState();
  }

  @override
  void dispose() {
//    round.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => round,
      child: Builder(builder: (context) {
        return buildArea(context);
      }),
    );
  }

  Widget buildArea(BuildContext context) {
    final handler = Provider.of<RoundProvider>(context).roundHandler;
    if (handler == null)
      return LoadingSpinner();
    else if (handler.status == RoundStatus.IDLE)
      return StartArea();
    else
      return PlayArea();
  }
}
