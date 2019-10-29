import 'package:flaguru/widgets/difficulty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/screens/play_screen.dart';
import '../models/Enum.dart';

class DifficultyScreen extends StatelessWidget {
  static String routeName = '/difficulty_screen';
  int timerIconCode =58405;
  int poinIconCode= 57377;
  int infiniteIcon =60221;
  List checkPoint=['0/20','0/30','0/50',];
  
  // DifficultyScreen(
  //        this.checkPoint,
  //           );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 157, 173),
      body: 
        // child: Padding(
        //   padding: const EdgeInsets.all(30.0),
           Center(
            //  widthFactor: 300,
            // Center Aligment
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                diffculty_cart("Easy",this.checkPoint[0],"0/20",'/playscreen/easy',poinIconCode,timerIconCode),
                //  SizedBox(
                //   height: 50,
                // ),
                diffculty_cart("Normal", this.checkPoint[1], "0/30",'/playscreen/normal',poinIconCode,timerIconCode),
                //  SizedBox(
                //   height: 50,
                // ),
                diffculty_cart("Hard", this.checkPoint[2],"0/50",'/playscreen/hard',poinIconCode,timerIconCode),
                // SizedBox(
                //   height: 50,
                // ),
                diffculty_cart("Enless","", "","",infiniteIcon,infiniteIcon),
              ]),
          // ),
        // ),
      ),
    );
  }
}
              // SizedBox(
              //   height: 50,
              // ),
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
