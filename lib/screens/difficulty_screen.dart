import 'package:flaguru/widgets/difficulty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/screens/play_screen.dart';
import '../models/Enum.dart';
import 'package:flaguru/widgets/difficulty_screen_animation.dart';

class DifficultyScreen extends StatefulWidget {
  static String routeName = '/difficulty_screen';

  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();
}

class _DifficultyScreenState extends State<DifficultyScreen> with SingleTickerProviderStateMixin {
  bool animated = false;
  int timerIconCode = 58405;
  int poinIconCode = 57710;
  int infiniteIcon = 60221;

  AnimationController _animatedContainer;
  Difficulty_screen_animation _difficulty_screen_animation;

  //TODO Making dynamic increment number to playcheckpoint
  final List arrayofCheckPoint = [
    '0/20',
    '0/30',
    '0/50',
  ];

  @override
  _DifficultyScreenState({
    arrayofCheckPoint,
  });

  @override
  void initState() {
    _animatedContainer = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _difficulty_screen_animation = Difficulty_screen_animation(_animatedContainer);

    _animatedContainer.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animatedContainer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 1, 157, 173),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
              child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                    opacity: _difficulty_screen_animation.popUp,
                    child: diffculty_cart("Easy", "150", this.arrayofCheckPoint[0], Difficulty.EASY,
                        poinIconCode, timerIconCode),
                  ),
                  FadeTransition(
                    opacity: _difficulty_screen_animation.popUp,
                    child: diffculty_cart("Normal", "120", this.arrayofCheckPoint[1],
                        Difficulty.NORMAL, poinIconCode, timerIconCode),
                  ),
                  FadeTransition(
                    opacity: _difficulty_screen_animation.popUp,
                    child: diffculty_cart("Hard", "100", this.arrayofCheckPoint[2], Difficulty.HARD,
                        poinIconCode, timerIconCode),
                  ),
                  FadeTransition(
                    opacity: _difficulty_screen_animation.popUp,
                    child: diffculty_cart(
                        "Endless", "", "", Difficulty.HARD, infiniteIcon, infiniteIcon),
                  ),
                ]),
          )),
        ));
  }
}
