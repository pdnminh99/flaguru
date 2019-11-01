import 'package:flutter/material.dart';

import '../utils/global_audio_player.dart';

class ResultAreaAnimation {
  final Animation<double> _controller;
  Animation<double> bgOpacity;
  Animation<double> right;
  Animation<double> life;
  Animation<double> time;
  Animation<double> bgScore;
  Animation<double> score;
  Animation<double> best;

  ResultAreaAnimation(this._controller) {
    bgOpacity = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.05)));
    right = CurvedAnimation(parent: _controller, curve: Interval(0.05, 0.25));
    life = CurvedAnimation(parent: _controller, curve: Interval(0.25, 0.4));
    time = CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.6));
    bgScore = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Interval(0.6, 0.75, curve: Curves.bounceOut)));
    score = CurvedAnimation(parent: _controller, curve: Interval(0.7, 0.95));
    best = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.95, 1)));

    _controller.addListener(playSoundRight);
    _controller.addListener(playSoundLife);
    _controller.addListener(playSoundTime);
    _controller.addListener(playSoundScore);
  }

  void playSoundRight() {
    if (_controller.value > 0.05) {
      audioPlayer?.playSoundResult();
      _controller.removeListener(playSoundRight);
    }
  }

  void playSoundLife() {
    if (_controller.value > 0.25) {
      audioPlayer?.playSoundResult();
      _controller.removeListener(playSoundLife);
    }
  }

  void playSoundTime() {
    if (_controller.value > 0.4) {
      audioPlayer?.playSoundResult();
      _controller.removeListener(playSoundTime);
    }
  }

  void playSoundScore() {
    if (_controller.value > 0.7) {
      audioPlayer?.playSoundScore();
      _controller.removeListener(playSoundScore);
    }
  }
}
