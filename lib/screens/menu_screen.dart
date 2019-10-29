import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/User.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/info_screen.dart';
import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/menu_card.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  var auth = Authentication();
  User _currentuser;
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    this.auth.getCurrentUser().then((user) {
      _currentuser = user;
    });
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  void gotoPlayScreen(BuildContext context) {
    //Navigator.pushNamed(context, DifficultyScreen.routeName);
    Navigator.pushNamed(context, DifficultyScreen.routeName);
  }

  void gotoLogin() {
    this.auth.handleSignIn().then((FirebaseUser user) {
      print(this.auth.getCurrentUser());
      return this.auth.getCurrentUser();
    }).then((user) {
      setState(() => {
       this._currentuser = user
      });
    }).catchError((e) => print("myerr" + e));
  }

  void gotoProfile(BuildContext context){
      Navigator.popAndPushNamed(
          context, InfoScreen.routeName);
  }
  void gotoTutorial(BuildContext context) {}

  void gotoSetting(BuildContext context) {}

  void gotoAbout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    //final double _width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
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
                        Transform(
                            transform: Matrix4.translationValues(
                                animation.value * 600, 0, 0),
                            child: Menu(gotoPlayScreen, Menu_Icon.play, "Play",
                                null, context)),
                        SizedBox(
                          height: 30,
                        ),
                        Transform(
                            transform: Matrix4.translationValues(
                                animation.value * 700, 0, 0),
                            child: _currentuser != null  ? Menu(gotoProfile, Menu_Icon.swords, "Profile", _currentuser.avatar, context) : Menu(gotoLogin, Menu_Icon.swords, "Login",
                                'G', context) ),
                        SizedBox(
                          height: 30,
                        ),
                        Transform(
                            transform: Matrix4.translationValues(
                                animation.value * 800, 0, 0),
                            child: Menu(gotoTutorial, Menu_Icon.open_book,
                                "Tutorial", null, context)),
                        SizedBox(
                          height: 30,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animation.value * 900, 0, 0),
                          child: Menu(gotoSetting, Menu_Icon.settings,
                              "Settings", null, context),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animation.value * 1000, 0, 0),
                          child: Menu(gotoAbout, Menu_Icon.info_outline,
                              "About", null, context),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
