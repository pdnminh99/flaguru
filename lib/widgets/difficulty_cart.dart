import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';


class diffculty_cart extends StatelessWidget {
  String name;
  String point;
  String timer;
  Difficulty difficulty;
  int pointIcon;
  int timerIcon;
  double iconSize=30;
  BuildContext contextparam;
  diffculty_cart(this.name, this.timer, this.point, this.difficulty,
      this.pointIcon, this.timerIcon);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
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
        Navigator.pushReplacementNamed(context, PlayScreen.routeName, arguments: difficulty);
      },
      child: Container(
        height: _height*0.164,
        width: _width*0.78,
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: _height*0.055,
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
                        fontSize: _height*0.044,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(IconData(pointIcon, fontFamily: 'MaterialIcons'),size: _height*0.044,),
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
                        fontSize: _height*0.044,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(IconData(timerIcon, fontFamily: 'MaterialIcons'),size: _height*0.044,),
                  ],
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: 5),
            // ),
          ],
        ),
      ),
    );
  }
}
