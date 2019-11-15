import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';

class ResultButtonArea extends AnimatedWidget {
  final Difficulty difficulty;

  ResultButtonArea({@required this.difficulty, Animation<double> controller})
      : super(listenable: controller);

  @override
  Widget build(BuildContext context) {
    final controller = listenable as Animation<double>;
    final animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCirc));

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getButton(animation.value * constraints.maxHeight * 0.8, Icons.menu,
                  () => navigateToMenu(context)),
              const SizedBox(width: 15),
              getButton(animation.value * constraints.maxHeight * 0.9, Icons.refresh,
                  () => restart(context, difficulty)),
              const SizedBox(width: 15),
              getButton(animation.value * constraints.maxHeight * 0.8, Icons.share, () {}),
            ],
          ),
        );
      },
    );
  }

  Widget getButton(double width, IconData icon, Function onPress) {
    return SizedBox(
      height: width,
      width: width,
      child: RaisedButton(
        padding: const EdgeInsets.all(0),
        elevation: 10,
        color: Colors.white.withOpacity(0.9),
        onPressed: onPress,
        child: Icon(icon, size: width * 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  void navigateToMenu(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MenuScreen.routeName);
  }

  void restart(BuildContext context, Difficulty difficulty) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => DifficultyScreen(diff: difficulty)));
  }
}
