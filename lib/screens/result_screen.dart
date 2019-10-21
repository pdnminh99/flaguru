import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/utils/enum_string.dart';
import 'package:flaguru/widgets/history_area.dart';
import 'package:flaguru/widgets/result_area.dart';
import 'package:flaguru/widgets/result_button_area.dart';
import 'package:flaguru/widgets/result_screen_animation.dart';
import 'package:flaguru/widgets/round_history_button.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final Result result;

  ResultScreen(this.result);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  ResultScreenAnimation animation;

  AnimationController historyController;

  bool showHistoryBtn = true;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    animation = ResultScreenAnimation(controller);
    controller.forward();

    historyController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed)
              setState(() => showHistoryBtn = true);
          });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var historyInitHeight = height * 0.07;

    return Scaffold(
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
                                controller: animation.resultButtonArea),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (!showHistoryBtn)
                Container(
                  width: width,
                  height: height,
                  alignment: Alignment.bottomCenter,
                  child: HistoryArea(
                    initHeight: historyInitHeight,
                    controller: historyController,
                    reverseAnim: reverseHistoryAnim,
                  ),
                ),
              if (showHistoryBtn)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: width,
                    height: historyInitHeight,
                    alignment: Alignment.center,
                    child: FadeTransition(
                      opacity: animation.historyBtn,
                      // change to animated widget
                      child: RoundHistoryButton(showHistory: () {
                        historyController.forward();
                        setState(() {
                          showHistoryBtn = false;
                        });
                      }),
                    ),
                  ),
                ),
            ],
          )),
    );
  }

  void reverseHistoryAnim() {
    historyController.reverse();
  }

  Widget buildResultTitle(String title) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2, 2),
              blurRadius: 5,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDifficultyText(Difficulty difficulty) {
    return Center(
      child: Text(
        EnumString.getDifficulty(difficulty),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
