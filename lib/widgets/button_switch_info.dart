import 'package:flutter/material.dart';

class ButtonSwitchButtonLogout extends StatelessWidget {
  final Function switchuser;
  final Function signout;

  ButtonSwitchButtonLogout({
  @required this.switchuser, 
  @required this.signout
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      width: 300,
      height: 50,
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
                    color: Colors.purpleAccent,
                    child: Text('Switch Accout', style: TextStyle(fontSize: 15.0),),
                  ))),
          SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    signout();
                  },
                  color: Colors.purpleAccent,
                  child: Text('Logout', style: TextStyle(fontSize: 15.0),),
                ),
              )),
        ],
      ),
    );
  }
}
