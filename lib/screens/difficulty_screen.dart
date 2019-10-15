import 'package:flaguru/widgets/difficulty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/screens/play_screen.dart';
class DifficultyScreen extends StatelessWidget {
  static String routeName = '/difficulty_screen';
  int timerIconCode =58405;
  int poinIconCode= 57377;
  int infiniteIcon =60221;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 157, 173),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          // Center Aligment
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              diffculty_cart("Easy", "0/20", "120",PlayScreen.routeName,poinIconCode,timerIconCode),
               SizedBox(
                height: 50,
              ),
              diffculty_cart("Normal", "0/30", "100",PlayScreen.routeName,poinIconCode,timerIconCode),
               SizedBox(
                height: 50,
              ),
              diffculty_cart("Hard", "0/50", "100",PlayScreen.routeName,poinIconCode,timerIconCode),
              SizedBox(
                height: 50,
              ),
              diffculty_cart("Enless","", "",PlayScreen.routeName,infiniteIcon,infiniteIcon),
            ]),
        ),
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
