import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/info_screen.dart';
import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/menu_card.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static String routeName = '/';
  var auth = Authentication();
  void gotoPlayScreen(BuildContext context) {
    //Navigator.pushNamed(context, DifficultyScreen.routeName);
    Navigator.popAndPushNamed(context, DifficultyScreen.routeName);
  }

  void gotoLogin(BuildContext context) {
    this.auth.handleSignIn().then((FirebaseUser user) {
      print(this.auth.getCurrentUser());
      return this.auth.getCurrentUser();
    }).then((user) {
      Navigator.pushNamed(context, InfoScreen.routeName);
    }).catchError((e) => print("myerr" + e));
  }

  void gotoTutorial(BuildContext context) {}

  void gotoSetting(BuildContext context) {}

  void gotoAbout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 157, 173),
      body: Stack(
        children: <Widget>[
          Container(
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     colorFilter: ColorFilter.mode(Color.fromRGBO(245,245 , 245, 0.8), BlendMode.dstATop),
              //     image: AssetImage("./assets/background/background_menu_screen.gif"),
              //     fit: BoxFit.fitHeight)),
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Menu(gotoPlayScreen, Menu_Icon.play, "Play", null, context),
                  SizedBox(
                    height: 30,
                  ),
                  Menu(gotoLogin, Menu_Icon.swords, "Login", "G", context),
                  SizedBox(
                    height: 30,
                  ),
                  Menu(gotoTutorial, Menu_Icon.open_book, "Tutorial", null,
                      context),
                  SizedBox(
                    height: 30,
                  ),
                  Menu(gotoSetting, Menu_Icon.settings, "Settings", null,
                      context),
                  SizedBox(
                    height: 30,
                  ),
                  Menu(gotoAbout, Menu_Icon.info_outline, "About", null,
                      context),
                ],
              )),
        ],
      ),
    );
  }
}
