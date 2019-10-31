import 'package:flutter/material.dart';

class Difficulty_screen_animation{
  //Stagged Animations
  int playerCheckpoint;
  final AnimationController _controller;

  Animation<int> playerCheckpoint_Ani;
  Animation<double> popUp;
  Difficulty_screen_animation(
    this._controller
  ){
    playerCheckpoint_Ani = Tween<int>(begin: 0,end: this.playerCheckpoint).animate(CurvedAnimation(
      parent: this._controller,
      curve: Interval(0.5, 0.7),
    ));
    popUp=Tween<double>(begin: 0.2,end: 1).animate(this._controller);
  }
}