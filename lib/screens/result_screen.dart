import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/Result.dart';
import 'package:flaguru/utils/enum_string.dart';
import 'package:flaguru/widgets/history_area.dart';
import 'package:flaguru/widgets/result_area.dart';
import 'package:flaguru/widgets/result_button_area.dart';
import 'package:flaguru/widgets/result_screen_animation.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/models/ProfileProvider.dart';
class ResultScreen extends StatefulWidget {
  final Result result;

  ResultScreen(this.result);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with TickerProviderStateMixin {
  AnimationController controller;
  ResultScreenAnimation animation;

  @override
  void initState() {
    controller = AnimationController(duration: Duration(milliseconds: 5000), vsync: this);
    animation = ResultScreenAnimation(controller);
    controller.forward();  
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35,
          shadows: <Shadow>[
            Shadow(offset: Offset(2, 2), blurRadius: 5, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget buildDifficultyText(Difficulty difficulty) {
        try{
          print(ProfileProvider.profileInstance.getData(Difficulty.EASY));
        }catch(e)
        {
          return e;
        }
    return Center(
      child: Text(
        EnumString.getDifficulty(difficulty),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
    );
  }
}
