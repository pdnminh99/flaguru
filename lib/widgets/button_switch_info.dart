import 'package:flutter/material.dart';

class ButtonSwitchButtonLogout extends StatelessWidget {
  final Function switchuser;
  final Function signout;
  final BuildContext paramcontext;
  ButtonSwitchButtonLogout({
    @required this.switchuser,
    @required this.signout,
    @required this.paramcontext,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double _height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: 300,
      height: _height * 0.068,
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      switchuser();
                    },                 
                    color: Color.fromRGBO(1, 157, 173, 1),
                    child: Text(
                      'Switch Account',
                      style: TextStyle(
                          fontSize: _height * 0.02, fontWeight: FontWeight.bold),
                    ),
                  ))),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 1,
              child: Container(
                height: _height * 0.7,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    signout(paramcontext);
                  },
                  color: Color.fromRGBO(1, 157, 173, 1),
                  child: Text(
                    'Logout',
                    style:
                        TextStyle(fontSize: _height * 0.02, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
