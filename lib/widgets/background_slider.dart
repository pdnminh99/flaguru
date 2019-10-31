import 'dart:async';

import 'package:flutter/material.dart';

class BackgroundSlider extends StatefulWidget {
  @override
  _BackgroundSliderState createState() => _BackgroundSliderState();
}

class _BackgroundSliderState extends State<BackgroundSlider> {
  PageController controller;

  @override
  void initState() {
    controller = PageController();
    startSlider(7);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startSlider(int interval) {
    Timer(const Duration(seconds: 1), () {
      toNextPage(interval);
      Timer.periodic(Duration(seconds: interval), (_) => toNextPage(interval));
    });
  }

  void toNextPage(int interval) =>
      controller.nextPage(duration: Duration(seconds: interval), curve: Curves.linear);

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/background/World-Map-0201.png',
      'assets/background/World-Map-0202.png',
      'assets/background/World-Map-0203.png',
    ];

    return Container(
      color: const Color(0xff019dad),
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return Image.asset(images[index % images.length], fit: BoxFit.fitWidth);
            },
          ),
          Positioned.fill(child: Container(color: Colors.transparent)),
        ],
      ),
    );
  }
}
