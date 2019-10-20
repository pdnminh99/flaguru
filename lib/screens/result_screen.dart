import 'package:flaguru/widgets/result_area.dart';
import 'package:flaguru/widgets/result_button_area.dart';
import 'package:flaguru/widgets/result_screen_animation.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final Result result = Result();

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  ResultScreenAnimation animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    animation = ResultScreenAnimation(controller);
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff019dad),
      body: WillPopScope(
          onWillPop: () async => false,
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                height: height * 0.15,
                child: FadeTransition(
                  opacity: animation.titleOpacity,
                  child: getTitleResults('RESULTS'),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height * 0.5,
                    child: ResultArea(
                      animation: animation.resultArea,
                      bottomMargin: height * 0.08,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: width,
                      height: height * 0.16,
                      child: FadeTransition(
                        opacity: animation.resultButtonArea,
                        child: ResultButtonArea(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget getTitleResults(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}

class Result {
  final right = 15;
  final life = 3;
  final time = 80;
  final point = 1200;
}
