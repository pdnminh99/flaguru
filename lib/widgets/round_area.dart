import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Enum.dart';
import '../utils/round_provider.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/play_area.dart';

class RoundArea extends StatelessWidget {
  final Difficulty difficulty;

  RoundArea(this.difficulty);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => RoundProvider(difficulty),
      child: Builder(builder: (context) {
        return buildArea(context);
      }),
    );
  }

  Widget buildArea(BuildContext context) {
    final handler = Provider.of<RoundProvider>(context).roundHandler;
    if (handler == null)
      return LoadingSpinner();
    else
      return PlayArea();
  }
}
