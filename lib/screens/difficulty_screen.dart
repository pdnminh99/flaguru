import 'dart:ffi';

import 'package:flutter/material.dart';

class DifficultyScreen extends StatelessWidget {
  static String routeName = '/difficulty_screen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          // Center Aligment
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                // padding: EdgeInsets.all(1),
                onPressed: () {
                  print("@@@");
                },
                child: Container(
                  height: 120,
                  // color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Easy",
                        style: TextStyle(
                          fontSize: 40.0,
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
                                "0/30",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.games),
                            ],
                          ),
                          SizedBox(width: 70,),
                          Row(
                            children: <Widget>[
                              Text(
                                "120",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.timer)
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                padding: EdgeInsets.all(1),
                onPressed: () {
                  print("@@@");
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //   // borderRadius: BorderRadius.circular(15.0),
                  //   border: Border.all(
                  //     width: 2
                  //   )
                  // ),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Normal",
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 10,
                        thickness: 5,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text(
                                "0/30",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.games),
                            ],
                          ),
                          Wrap(
                            spacing: 100.0,
                          ),
                          // Expanded(
                          //   flex: 1000,
                          //   child: Container(),
                          // ),
                          Wrap(
                            children: <Widget>[
                              Text(
                                "120",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.timer)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                padding: EdgeInsets.all(1),
                onPressed: () {
                  print("@@@");
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //   // borderRadius: BorderRadius.circular(15.0),
                  //   border: Border.all(
                  //     width: 2
                  //   )
                  // ),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Difficult",
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 10,
                        thickness: 5,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text(
                                "0/30",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.games),
                            ],
                          ),
                          Wrap(
                            spacing: 100.0,
                          ),
                          // Expanded(
                          //   flex: 1000,
                          //   child: Container(),
                          // ),
                          Wrap(
                            children: <Widget>[
                              Text(
                                "120",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.timer)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                padding: EdgeInsets.all(1),
                onPressed: () {
                  print("@@@");
                },
                child: Container(
                  // decoration: BoxDecoration(
                  //   // borderRadius: BorderRadius.circular(15.0),
                  //   border: Border.all(
                  //     width: 2
                  //   )
                  // ),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Endless",
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                      Divider(
                        color: Colors.black38,
                        height: 10,
                        thickness: 5,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text(
                                "0/30",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.games),
                            ],
                          ),
                          Wrap(
                            spacing: 100.0,
                          ),
                          // Expanded(
                          //   flex: 1000,
                          //   child: Container(),
                          // ),
                          Wrap(
                            children: <Widget>[
                              Text(
                                "120",
                                style: TextStyle(fontSize: 30.0),
                              ),
                              Icon(Icons.timer)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DifficultyTitle extends StatelessWidget{

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Text("0/30",
//             style: TextStyle(
//             fontSize: 30.0
//            ),
//            ),
//           Icon(
//           Icons.games
//           ),
//         ],
//       ),
//     );
//   }

// }
