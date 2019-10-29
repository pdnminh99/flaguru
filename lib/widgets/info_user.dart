import 'package:flutter/material.dart';

// class InfoUser extends StatefulWidget {
//   @override
//   _InfoUserState createState() => _InfoUserState();
// }

// class _InfoUserState extends State<InfoUser> {
class InfoUser extends StatelessWidget {
  final String name;
  final String email;
  final String score;

  const InfoUser(
      {@required this.name, @required this.email, @required this.score});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 0.0),
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
      height: _height * 0.41,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Information',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
              width: double.infinity,
              height: _height * 0.273,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Name:', style: TextStyle(fontSize: 18.0)),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Text(                         
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(children: <Widget>[
                    Text('Email: ', style: TextStyle(fontSize: 18.0)),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                        child: Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ))
                  ]),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Score: ',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        score,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
