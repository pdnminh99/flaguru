import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';
import '../widgets/tutorial_widget/menuscreen_tutorial.dart';

class TutorialScreen extends StatelessWidget {
  static String routeName = "/tutorial_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        builder: Builder(builder: (context) => MenuScreenTutorial()),
      ),
    );
  }
}
