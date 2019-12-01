import 'dart:math';

import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/screens/tutorial_screen.dart';
import 'package:flaguru/utils/round_provider.dart';
import 'package:flaguru/widgets/tutorial_widget/until_tutorial/round_provider_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';

class BottomBarTutorial extends StatefulWidget {
  final GlobalKey nextkey;

  BottomBarTutorial(this.nextkey);
  @override
  _BottomBarTutorialState createState() => _BottomBarTutorialState();
}

class _BottomBarTutorialState extends State<BottomBarTutorial> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween(begin: pi / 2, end: 0.0).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   void _showDialog(){
     showDialog(
       context: context,
       builder : (BuildContext context){
         return AlertDialog(
           title: Text("Thank you", style: TextStyle(fontWeight: FontWeight.bold),),
           content: Text("Thank you for following our tutorial"),
           actions: <Widget>[
             FlatButton(
               child: Text('REPLAY', style: TextStyle(fontWeight: FontWeight.bold),),
               onPressed: ()=>{
                 Navigator.popAndPushNamed(context, TutorialScreen.routeName),
               },
             ),
             FlatButton(
               child: Text("QUIT", style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: ()=>{
                Navigator.popAndPushNamed(context, MenuScreen.routeName),
              },
             )
           ],
         );
       },
     );
   }
  @override
  Widget build(BuildContext context) {
    final round = Provider.of<RoundProvider>(context);
    final isOver = round.isOver;
    final isAnswered = round.isAnswered;

    if (isAnswered)
      _controller.forward();
    else
      _controller.reverse();

    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedBuilder(
              animation: animation,
              child: 
              Showcase(
                key: widget.nextkey,
                title: "Next question",
                titleTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                description: "touch this button to continue",
                onTargetClick: ()=> _showDialog(),
                disposeOnTap: true,

              child : Stack(
                children: <Widget>[
                  SizedBox(
                    height: constraint.maxHeight * 0.7,
                    width: constraint.maxWidth * 0.2,
                    child: RaisedButton(
                      elevation: 5,
                      color: Colors.white,
                      onPressed: () => _showDialog(),
                      child: Icon(
                        (isOver) ? Icons.airplay : Icons.arrow_forward,
                        size: constraint.maxHeight * 0.55,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Visibility(
                      visible: !isAnswered,
                      child: Positioned.fill(child: Container(color: Colors.transparent))),
                ],
              ),),
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationX(animation.value),
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
