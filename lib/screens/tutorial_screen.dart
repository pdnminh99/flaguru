import 'package:flaguru/widgets/tutorial_widget/menuscreen_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class TutorialScreen extends StatefulWidget {
  static String routeName = "/tutorial_screen";

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowCaseWidget(
        builder: Builder(builder: (context) => MenuScreenTutorial()),
      ),
    );
  }
}
