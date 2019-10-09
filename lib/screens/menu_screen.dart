import 'package:flag_quiz/widgets/menu_card.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  void inra() {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 51, 148, 244),
        body: Container(
          padding: EdgeInsets.fromLTRB(40, 130, 40, 100),
          child: Align(
            alignment: Alignment.center,
              widthFactor: double.infinity,
              heightFactor: 300,
              child: Column(
                children: <Widget>[
                  
                  Menu(inra, "Play",null),
                  SizedBox(height: 30,),
                  Menu(inra,"Compete","G"),
                  SizedBox(height: 30,),
                  Menu(inra,"Tutorial",null),
                  SizedBox(height: 30,),
                  Menu(inra,"Settings",null),
                  SizedBox(height: 30,),
                  Menu(inra,"About",null),
                  ],
              )),
        ));
  }
}
