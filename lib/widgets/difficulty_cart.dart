import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';

class diffculty_cart extends StatelessWidget{
   String name;
   String point;
   String timer;
  String routename;
   Function navigator;
   int pointIcon;
   int timerIcon;
  BuildContext contextparam;
   diffculty_cart(this.name,this.timer,this.point,this.routename,this.pointIcon,this.timerIcon);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                // padding: EdgeInsets.all(1),
                onPressed: (){
                  Navigator.pushNamed(context, routename);
                },
                child: Container(
                  height: 120,
                  // color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                      color: Colors.black,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                    ),
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 10,
                        thickness: 3,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
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
                      fontWeight: FontWeight.w600,
                    ),
                              ),
                              Icon(
                                IconData(
                                  pointIcon, fontFamily: 'MaterialIcons')
                                )
                              ,
                            ],
                          ),
                          SizedBox(width: 70,),
                          Row(
                            children: <Widget>[
                              Text(
                                timer,
                                style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                              ),
                              Icon(
                                IconData(
                                  timerIcon, fontFamily: 'MaterialIcons')
                                )
                              ,
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
             