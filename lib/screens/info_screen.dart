import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/widgets/background_info.dart';
import 'package:flaguru/widgets/button_switch_info.dart';
import 'package:flaguru/widgets/info_user.dart';
import 'package:flaguru/widgets/progress_user.dart';
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
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    print(_height);
    print(_width);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        body: Column(
          children: <Widget>[
            Container(
                height: _height * 0.232,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[ 
                    BackgroundInfo(),
                    Align(
                      alignment: Alignment(0, 1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          this._currentUser.photoURL,
                          height: _height * 0.125,
                          width: _height * 0.125,
                          repeat: ImageRepeat.noRepeat,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              // double paddingvl = _height*0.04;
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
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
      ),
    );
  }
}
