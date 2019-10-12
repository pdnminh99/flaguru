
import 'package:flaguru/screens/play_screen.dart';
import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/menu_card.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = '/menu_screen';
  void go_to_play_screen(BuildContext context) {
    Navigator.pushNamed(context, PlayScreen.routeName);   
  }
  void go_to_compete(BuildContext context)
  {

  }
  void go_to_tutorial(BuildContext context)
  {

  }
  
  void go_to_seetings(BuildContext context)
  {

  }
  void go_to_about(BuildContext context)
  {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 1, 157, 173),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Color.fromRGBO(245,245 , 245, 0.8), BlendMode.dstATop),
              image: AssetImage("./assets/background/background_menu_screen.gif"),
              fit: BoxFit.fitHeight)),
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[                  
                  Menu(go_to_play_screen,Menu_Icon.play, "Play",null,context),
                  SizedBox(height: 30,),
                  Menu(go_to_compete,Menu_Icon.swords,"Compete","G",context),
                  SizedBox(height: 30,),
                  Menu(go_to_tutorial,Menu_Icon.open_book,"Tutorial",null,context),
                  SizedBox(height: 30,),
                  Menu(go_to_seetings,Menu_Icon.settings,"Settings",null,context),
                  SizedBox(height: 30,),
                  Menu(go_to_about,Menu_Icon.info_outline,"About",null,context),
                  ],
              )),
        );
  }
}
