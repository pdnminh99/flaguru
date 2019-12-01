import 'package:flaguru/utils/round_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class RoundProviderTutorial extends RoundProvider
{
  RoundProviderTutorial(difficulty) : super(difficulty);
  bool popupthankyou = false;
 
  void getNextQuestiontutorial(BuildContext context) {
    // TODO: implement getNextQuestion
    popupthankyou = true;
    notifyListeners();
  }
}