import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/User.dart';
import 'package:flaguru/screens/difficulty_screen.dart';
import 'package:flaguru/screens/info_screen.dart';
import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/background_carousel.dart';
import 'package:flaguru/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  var auth = Authentication();
  User _currentUser;

  Animation<double> btnFlyInAnim;
  AnimationController btnFlyInController;
  AnimationController btnRotationController;

  Timer timer1;
  Timer timer2;

  bool shouldQuit;

  @override
  void initState() {
    this.auth.getCurrentUser().then((user) {
      setState(() {
       this._currentUser = user; 
      });
    });

    btnFlyInController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    btnFlyInAnim = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: btnFlyInController, curve: Curves.fastOutSlowIn));
    btnFlyInController.forward();

    btnRotationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    setBtnRotationTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer1?.cancel();
    timer2?.cancel();
    btnFlyInController.dispose();
    btnRotationController.dispose();
    super.dispose();
  }

  setBtnRotationTimer() {
    timer1 = Timer(const Duration(seconds: 2), () {
      btnRotationController.forward();
      timer2 = Timer.periodic(const Duration(seconds: 4), (_) {
        btnRotationController.value = 0;
        btnRotationController.forward();
      });
    });
  }

  void gotoDiffScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DifficultyScreen.routeName);
  }

  void gotoLogin() {
    this.auth.handleSignIn().then((FirebaseUser user) {
      print(this.auth.getCurrentUser());
      return this.auth.getCurrentUser();
    }).then((user) {
      setState(() => {this._currentUser = user});
    }).catchError((e) => print("myerr" + e));
  }

  void gotoProfile(BuildContext context) {
    Navigator.popAndPushNamed(context, InfoScreen.routeName);
  }

  void gotoTutorial(BuildContext context) {}

  void gotoSetting(BuildContext context) {}

  void gotoAbout(BuildContext context) {}

  bool confirmQuit(BuildContext context) {
    final status = shouldQuit;
    if (!shouldQuit) {
      shouldQuit = true;
      Timer(const Duration(seconds: 2), () => shouldQuit = false);
      Scaffold.of(context).showSnackBar(buildSnackBar(2));
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    shouldQuit = false;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => confirmQuit(context),
            child: Stack(
              children: <Widget>[
                BackgroundCarousel(),
                buildMenuButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMenuButtons() {
    final sizedBox = const SizedBox(height: 30);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildMenuButtonWrapper(600, gotoDiffScreen, Menu_Icon.play, "Play", 0, 0.2),
          sizedBox,
          _currentUser != null
              ? buildMenuButtonWrapper(700, gotoProfile, Icons.face, "Profile", 0.15, 0.35,
                  rightIcon: _currentUser.avatar)
              : buildMenuButtonWrapper(700, gotoLogin, Icons.person_outline, "Login", 0.15, 0.35,
                  rightIcon: 'G'),
          sizedBox,
          buildMenuButtonWrapper(800, gotoTutorial, Icons.bookmark_border, "Tutorial", 0.3, 0.5),
          sizedBox,
          buildMenuButtonWrapper(900, gotoSetting, Menu_Icon.settings, "Settings", 0.45, 0.65),
          sizedBox,
          buildMenuButtonWrapper(1000, gotoAbout, Menu_Icon.info_outline, "About", 0.6, 0.8),
        ],
      ),
    );
  }

  Widget buildMenuButtonWrapper(
      int offsetX, Function onPress, IconData leftIcon, String title, double begin, double end,
      {String rightIcon}) {
    return AnimatedBuilder(
      animation: btnFlyInAnim,
      child: MenuButton(onPress, leftIcon, title, btnRotationController,
          begin: begin, end: end, rightIcon: rightIcon),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(btnFlyInAnim.value * offsetX, 0),
          child: child,
        );
      },
    );
  }

  Widget buildSnackBar(int duration) {
    return SnackBar(
      elevation: 0,
      duration: Duration(seconds: duration),
      backgroundColor: Colors.black38,
      content: Text(
        'Press again to quit',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
