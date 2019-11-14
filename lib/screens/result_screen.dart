import 'package:flutter/material.dart';

import '../models/Enum.dart';
import '../models/Result.dart';
import '../utils/enum_string.dart';
import '../widgets/history_area.dart';
import '../widgets/result_area.dart';
import '../widgets/result_button_area.dart';
import '../widgets/result_screen_animation.dart';
import '../models/ProfileProvider.dart';

class ResultScreen extends StatefulWidget {
  final Result result;

  ResultScreen(this.result);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  ResultScreenAnimation animation;
  String highestScore = '--';

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    animation = ResultScreenAnimation(controller);
    controller.forward();

    getBestScore();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getBestScore() {
    ProfileProvider().getLocalResult(widget.result.level).then((details) => setState(() {
          highestScore = details.highestScore.toString();
        }));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final historyBtnHeight = 50.0;

    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color(0xff019dad),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: height * 0.1,
                      child: FadeTransition(
                        opacity: animation.titleOpacity,
                        child: buildResultTitle('RESULTS'),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: height * 0.05,
                      child: FadeTransition(
                        opacity: animation.titleOpacity,
                        child: buildDifficultyText(widget.result.level),
                      ),
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: height * 0.45,
                          child: ResultArea(
                            result: widget.result,
                            controller: animation.resultArea,
                            bottomMargin: height * 0.06,
                            highestScore: highestScore,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: width,
                            height: height * 0.12,
                            child: FadeTransition(
                              opacity: animation.resultButtonArea,
                              child: ResultButtonArea(
                                difficulty: widget.result.level,
                                controller: animation.resultButtonArea,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: animation.historyBtnOffset,
                    child: HistoryArea(
                      logs: widget.result.answerLogs,
                      btnHeight: historyBtnHeight,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget buildResultTitle(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35,
          shadows: <Shadow>[
            const Shadow(offset: Offset(2, 2), blurRadius: 5, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget buildDifficultyText(Difficulty difficulty) {
    return Center(
      child: Text(
        EnumString.getDifficulty(difficulty),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
