import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/widgets/background_info.dart';
import 'package:flaguru/widgets/button_switch_info.dart';
import 'package:flaguru/widgets/info_user.dart';
import 'package:flaguru/widgets/progress_info.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  static String routeName = "/info_screen";
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  //pro
  var auth = Authentication();
  UserDetail _currentUser;

  //ctor
  _InfoScreenState() {
    this.auth.getCurrentUser().then((user) {
      setState(() {
        this._currentUser = user;
        this._currentUser.email =
            user.email[0].toUpperCase() + user.email.substring(1);
      });
    });
  }
  //meth
  void signout(BuildContext context) {
    // Navigator.pushNamed(context, MenuScreen.routeName);
    // Navigator.pop(context);
    this.auth.signOut().then((_) {}).catchError((err) => print(err));
    Navigator.popAndPushNamed(context, MenuScreen.routeName);
  }

  void switchuser() {
    this.auth.switchUser().then((_) {
      return this.auth.getCurrentUser();
    }).then((user) {
      setState(() {
        this._currentUser = user;
      });
    }).catchError((err) => print(err));
    print(this._currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Column(
        children: <Widget>[
          Container(
              height: 170,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  BackgroundInfo(),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Image.network(
                      this._currentUser.photoURL,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                ProgressUser(),
                InfoUser(
                  name: _currentUser.name,
                  email: _currentUser.email,
                  score: '100',
                ),
                ButtonSwitchButtonLogout(
                    signout: signout,
                    switchuser: switchuser,
                    paramcontext: context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
