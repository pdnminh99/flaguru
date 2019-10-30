import 'package:flaguru/widgets/difficulty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/screens/play_screen.dart';
import '../models/Enum.dart';


class DifficultyScreen extends StatefulWidget{
  static String routeName = '/difficulty_screen';
  @override
  _DifficultyScreenState createState() => _DifficultyScreenState();

}
class _DifficultyScreenState extends State<DifficultyScreen> with SingleTickerProviderStateMixin{
  bool animated = false;
  int timerIconCode =58405;
  int poinIconCode= 57377;
  int infiniteIcon =60221;
  AnimationController _animatedContainer;
  Animation<double> _animation;
  final List arrayofCheckPoint=['0/20','0/30','0/50',];
  @override
  _DifficultyScreenState(
    {
      arrayofCheckPoint,
    }
  );
  @override 
  void initState(){
    super.initState();
    // print(this.animated);
    super.initState();
    _animatedContainer = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween(begin: 90.0,end: 0.0).animate(_animatedContainer)
    ..addListener((){
      setState(() {
      });
    });
    _animatedContainer.forward();
    // this.animated = true;
  }
  @override
  void dispose() {
    _animatedContainer.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 157, 173),
      body: AnimatedBuilder( 
        animation: _animation,
        child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  diffculty_cart("Easy","150",this.arrayofCheckPoint[0],'/playscreen/easy',poinIconCode,timerIconCode),
                  diffculty_cart("Normal","120", this.arrayofCheckPoint[1], '/playscreen/normal',poinIconCode,timerIconCode),
                  diffculty_cart("Hard","100", this.arrayofCheckPoint[2],'/playscreen/hard',poinIconCode,timerIconCode),
                  diffculty_cart("Enless","", "","",infiniteIcon,infiniteIcon),
                  
                ]),
            // ),
          // ),
        ),
        builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(_animation.value,_animation.value),
          child: child,
        );
      }));
  }
  }



