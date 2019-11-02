import 'dart:async';

import 'package:flutter/material.dart';

class BackgroundCarousel extends StatefulWidget {
  @override
  _BackgroundCarouselState createState() => _BackgroundCarouselState();
}

class _BackgroundCarouselState extends State<BackgroundCarousel> {
  PageController controller;

  Timer timer1;
  Timer timer2;

  @override
  void initState() {
    controller = PageController();
    startSlider(6);
    super.initState();
  }

  @override
  void dispose() {
    timer1?.cancel();
    timer2?.cancel();
    controller.dispose();
    super.dispose();
  }

  void startSlider(int interval) {
    timer1 = Timer(const Duration(seconds: 1), () {
      toNextPage(interval);
      timer2 = Timer.periodic(Duration(seconds: interval), (_) => toNextPage(interval));
    });
  }

  void toNextPage(int interval) =>
      controller.nextPage(duration: Duration(seconds: interval), curve: Curves.linear);

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/background/World-Map-0201.png',
      'assets/background/World-Map-0203.png',
      'assets/background/World-Map-0202.png',
    ];

    return Container(
      color: const Color(0xff019dad),
      child: Stack(
        children: <Widget>[
          PageView.builder(
            controller: controller,
            reverse: true,
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
