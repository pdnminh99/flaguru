import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/utils/round_provider.dart';
import 'package:flaguru/widgets/info_bar.dart';
import 'package:flaguru/widgets/tutorial_widget/style_tutorial/textstyle_tutorial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';

class InfoBarTutorial extends InfoBar
{
  final GlobalKey lifekey;
  final GlobalKey totalquestionkey;
  final TextStyleTutorial mytext = TextStyleTutorial();
  InfoBarTutorial(this.lifekey, this.totalquestionkey);
  @override 
  Widget build (BuildContext context)
  {
    final provider = Provider.of<RoundProvider>(context);
    final round = provider.roundHandler;
    final quizTotal =
        (provider.rule.difficulty == Difficulty.ENDLESS) ? '--' : provider.rule.quizTotal;

    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Showcase(
                key : lifekey,
                title: "Your Life",
                titleTextStyle: mytext.tiltestyle,
                description: "If you lost all your life, The game will end\ntouch screen to continue",
                descTextStyle: mytext.descstyle,
                child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (var i = 0; i < round.remainLives; i++)
                    getRemainLifeDot(constraint.maxHeight * 0.4),
                  for (var i = 0, left = round.lifeCount - round.remainLives; i < left; i++)
                    getLostLifeDot(constraint.maxHeight * 0.4),
                ],
              )),
              Text(
                '${provider.index + 1} of $quizTotal',
                style: TextStyle(
                  fontSize: constraint.maxHeight * 0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
