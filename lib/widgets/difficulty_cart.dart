import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class diffculty_cart extends StatelessWidget {
  String name;
  String point;
  String timer;
  String routename;
  Function navigator;
  int pointIcon;
  int timerIcon;
  double iconSize=30;
  BuildContext contextparam;
  diffculty_cart(this.name, this.timer, this.point, this.routename,
      this.pointIcon, this.timerIcon);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // padding: EdgeInsets.all(1),
      onPressed: () {
        // Navigator.pushNamed(context, routename);
        // Navigator.pop(context,MaterialPageRoute(builder: (context) => PlayScreen(difficulty: routename,)));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PlayScreen(difficulty: routename,)));
        // Navigator.pop(context);
        Navigator.popAndPushNamed(context,this.routename);
      },
      child: Container(
        height: 115,
        width: 320,
        // color: Colors.white,
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 38,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(
              color: Colors.black38,
              height: 10,
              thickness: 3,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      point,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(IconData(pointIcon, fontFamily: 'MaterialIcons'),size: 25,),
                  ],
                ),
                SizedBox(
                  width: 70,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      timer,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(IconData(timerIcon, fontFamily: 'MaterialIcons'),size: iconSize,),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
            ),
          ],
        ),
      ),
    );
  }
}
