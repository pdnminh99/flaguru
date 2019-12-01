
import 'package:flutter/material.dart';

class ButtonSwitchButtonLogout extends StatefulWidget {
  final Function signOut;
  final Function switchUser;

  const ButtonSwitchButtonLogout( this.signOut, this.switchUser);
  @override
  _ButtonSwitchButtonLogoutState createState() =>
      _ButtonSwitchButtonLogoutState();
}

class _ButtonSwitchButtonLogoutState extends State<ButtonSwitchButtonLogout>
    with SingleTickerProviderStateMixin {
  Animation<double> _btnSwitchAnimation;
  Animation<double> _btnLogoutAnimation;
  Animation<double> _btnMainAnimation;
  Animation<Color> _btnMainColorAnimation;
  CurvedAnimation _curvedAnimation;
  AnimationController _animationController;
  bool isOpen = false;
  double _width = 56;

  @override
  void initState() {
    // TODO: implement initState
    //curve of logout and switch
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _curvedAnimation = CurvedAnimation(
        curve: Interval(0, 0.75, curve: Curves.easeIn), // delay
        parent: _animationController);

    //color animation of main button
    _btnMainColorAnimation = ColorTween(begin: Color.fromRGBO(34, 182, 191, 1), end: Colors.red)
        .animate(_curvedAnimation);

    _btnMainAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);

    _btnSwitchAnimation =
        Tween<double>(begin: _width*2, end: -40).animate(_curvedAnimation);

    _btnLogoutAnimation =
        Tween<double>(begin: _width, end: -20).animate(_curvedAnimation);


    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  checkisOpen() {
    if (!isOpen)
      _animationController.forward();
    else
     _animationController.reverse();
    isOpen = !isOpen;
  }

  void printt()
  {
    print('hello');
  }
  Widget buildbuttonSwitch() {
    return Transform(
      transform: Matrix4.translationValues(_btnSwitchAnimation.value, 0, 0),
      child: Container(
        width: 56,
        child: FloatingActionButton(
          heroTag: "btnSwitch", // set name to herotag to fix bug mutiple hero 
          backgroundColor: Colors.green,
          onPressed: () =>  widget.switchUser(),
          child: Icon(Icons.swap_vert),
        ),
      ),
    );
  }

  Widget buildbuttonLogout() {
    return Transform(
      transform: Matrix4.translationValues(_btnLogoutAnimation.value, 0, 0),
      child: Container(
        width: 56,
        child: FloatingActionButton(
          heroTag: "btnLogout",
          onPressed: () { widget.signOut(context); },
          child: Icon(Icons.input),
        ),
      ),
    );
  }

  Widget buildbuttonMain() {
    return FloatingActionButton(
      heroTag: "btnMain",
      backgroundColor: _btnMainColorAnimation.value,
      onPressed: () => checkisOpen(),
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _btnMainAnimation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        buildbuttonSwitch(),
        buildbuttonLogout(),
        buildbuttonMain(),
      ],
    );
  }
}
