import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Enum.dart';
import '../utils/round_provider.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/play_area.dart';
import '../widgets/start_area.dart';

class RoundArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildArea(context);
  }

  Widget buildArea(BuildContext context) {
    final roundHandler = Provider.of<RoundProvider>(context).roundHandler;

    if (roundHandler == null)
      return LoadingSpinner();
    else if (roundHandler.status == RoundStatus.IDLE)
      return StartArea();
    else
      return PlayArea();
  }
}
