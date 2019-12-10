import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/utils/round_provider.dart';
import 'package:flaguru/widgets/loading_spinner.dart';
import 'package:flaguru/widgets/round_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'play_area_tutorial.dart';

class RoundAreaTutorial extends RoundArea {
  RoundAreaTutorial(Difficulty difficulty, this.listkey) : super(difficulty);
  final List<GlobalKey> listkey;

  @override
  Widget buildArea(BuildContext context) {
    // TODO: implement buildArea
    final handler = Provider.of<RoundProvider>(context).roundHandler;
    if (handler == null)
      return LoadingSpinner();
    else
      return PlayAreaTutorial(listkey);
  }
}
