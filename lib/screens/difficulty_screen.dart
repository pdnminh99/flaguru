import 'package:flaguru/widgets/difficulty_cart.dart';
import 'package:flutter/material.dart';
import '../models/Enum.dart';

class DifficultyScreen extends StatelessWidget {
  static String routeName = '/difficulty_screen';
  int timerIconCode =58405;
  int poinIconCode= 57377;
  int infiniteIcon =60221;
  final List arrayofCheckPoint=['0/20','0/30','0/50',];
  @override
  DifficultyScreen(
    {
      arrayofCheckPoint,
    }
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 157, 173),
      body: Center(
            //  widthFactor: 300,
            // Center Aligment        // child: Padding(
            //   padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                diffculty_cart("Easy","150",this.arrayofCheckPoint[0],Difficulty.EASY,poinIconCode,timerIconCode),
                diffculty_cart("Normal","120", this.arrayofCheckPoint[1], Difficulty.NORMAL,poinIconCode,timerIconCode),
                diffculty_cart("Hard","100", this.arrayofCheckPoint[2],Difficulty.HARD,poinIconCode,timerIconCode),
                diffculty_cart("Enless","", "",Difficulty.EASY,infiniteIcon,infiniteIcon),
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
