import 'dart:async';
import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/background_carousel.dart';
import 'package:flaguru/widgets/menu_button.dart';
import 'package:flaguru/widgets/tutorial_widget/difficultyscreen_tutorial.dart';
import 'package:flaguru/widgets/tutorial_widget/style_tutorial/textstyle_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class MenuScreenTutorial extends StatefulWidget {
  //static String routeName = "/menuscreen_tutorial";
  @override
  _MenuScreenTutorialState createState() => _MenuScreenTutorialState();
}

class _MenuScreenTutorialState extends State<MenuScreenTutorial> with TickerProviderStateMixin {
  Animation<double> btnFlyInAnim;
  AnimationController btnFlyInController;
  AnimationController btnRotationController;
  TextStyleTutorial styleshowcase = TextStyleTutorial();

  Timer timer1;
  Timer timer2;

  bool shouldQuit;

  bool boolbuildshowcase = false;
  GlobalKey _keyofplaybutton = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ShowCaseWidget.of(context).startShowCase([_keyofplaybutton]));

    btnFlyInController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    btnFlyInAnim = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: btnFlyInController, curve: Curves.fastOutSlowIn));
    btnFlyInController.forward();

    //build show case when done animation fly
    btnFlyInAnim.addStatusListener((state) => {
          if (state == AnimationStatus.completed)
            {
              setState(() {
                boolbuildshowcase = true;
              })
            }
        });

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

  setbuildShowcasse() {}

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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Difftutorial()));
  }

  void gotoLogin() {
    Scaffold.of(context).showSnackBar(buildSnackBarPressPlayButton());
  }

  void gotoProfile(BuildContext context) {
    Scaffold.of(context).showSnackBar(buildSnackBarPressPlayButton());
    //Navigator.pushReplacementNamed(context, InfoScreen.routeName);
  }

  void gotoTutorial(BuildContext context) {
    Scaffold.of(context).showSnackBar(buildSnackBarPressPlayButton());
    //Navigator.pushReplacementNamed(context, TutorialScreen.routeName);
  }

  void gotoSetting(BuildContext context) {
    Scaffold.of(context).showSnackBar(buildSnackBarPressPlayButton());
    //Navigator.of(context).pushNamed(SettingsScreen.routeName);
  }

  void gotoAbout(BuildContext context) {
    Scaffold.of(context).showSnackBar(buildSnackBarPressPlayButton());
  }

  @override
  Widget build(BuildContext context) {
    shouldQuit = false;
    return Scaffold(
      body: Builder(
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
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
          boolbuildshowcase
              ? buildTutorialButtonPlay(context)
              : buildMenuButtonWrapper(600, gotoDiffScreen, Menu_Icon.play, "Play", 0, 0.2),
          sizedBox,
          buildMenuButtonWrapper(700, gotoLogin, Icons.person_outline, "Login", 0.15, 0.35,
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

  Widget buildTutorialButtonPlay(BuildContext context) {
    return Showcase(
      key: _keyofplaybutton,
      overlayOpacity: 0.7,
      description: "Touch this to play",
      descTextStyle: styleshowcase.descstyle,
      disposeOnTap: true,
      onTargetClick: () => {gotoDiffScreen(context)},
      child: Container(
          height: 59,
          width: 359,
          child: Center(
              child: buildMenuButtonWrapper(600, gotoDiffScreen, Menu_Icon.play, "Play", 0, 0.2))),
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

  Widget buildSnackBarPressPlayButton() {
    return SnackBar(
      content: Text(
        "Please touch play button to continue tutorial",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
