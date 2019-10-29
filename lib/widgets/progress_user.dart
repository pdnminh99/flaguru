import 'package:flutter/material.dart';

// class ProgressUser extends StatefulWidget {
//   @override
//   _ProgressUserState createState() => _ProgressUserState();
// }

// class _ProgressUserState extends State<ProgressUser> {
class ProgressUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    print(_height);
    return Container(
      margin: EdgeInsets.only(top: 0),
      height: _height * 0.1367,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border:
              Border.all(color: Color.fromRGBO(217, 217, 217, 0.8), width: 1),
          boxShadow: [
            BoxShadow(
                //color: Color.fromRGBO(250, 250, 250, 0.9),
                color: Color.fromRGBO(217, 217, 217, 1),
                offset: Offset(0, 0),
              
                blurRadius: 5.0)
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: _height * 0.0273,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              width: double.infinity,
              height: _height * 0.0341,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.0),
                border: Border.all(
                    color: Color.fromRGBO(217, 217, 217, 0.8), width: 1),
              ),
              child: LinearProgressIndicator(
                value: 0.3,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.teal[300]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
