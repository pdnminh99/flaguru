import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as prefix0;

class TutorialScreen extends StatefulWidget {
  static String routeName = "./tutorial_screen";
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(220, 220, 220, 1),
        appBar: AppBar(
          title: const Text('hello'),
        ),
        body: Container(
          width: 150,
          height: double.infinity,
          padding: EdgeInsets.only(top: 100, left: 10),
          child: Container(
            alignment: Alignment.center,
            width: 130,
            height: 260,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ExpandlistMenu(listoftitle[index]),
              itemCount: listoftitle.length,
            ),
          ),
        ),
      ),
    );
  }
}

List<TitleofDraw> listoftitle = <TitleofDraw>[
  //Play
  TitleofDraw(
    '1. Play',
  ),
  TitleofDraw(
    '1.1 Difficult Screen',
  ),
  TitleofDraw(
    '1.2 Play Screen',
  ),
  TitleofDraw(
    '1.3 Result Screen',
  ),
  //Login
  TitleofDraw(
    '2. Login',
  ),
  //Setting
  TitleofDraw(
    '3. Setting',
  )
];

class TitleofDraw {
  String titlename;
  //Ctor
  TitleofDraw(this.titlename);
}

class ExpandlistMenu extends StatelessWidget {
  final TitleofDraw titleofdraw;

  const ExpandlistMenu(this.titleofdraw);

  Widget _buildExpand(TitleofDraw titleparam) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: 30,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.1),
                blurRadius: 2,
              )
            ]),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          onTap: () => print('hello'),
          child: Container(
            padding: EdgeInsets.only(left: 5),
            alignment: Alignment.centerLeft,
              child: Text(
            titleparam.titlename,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13,
            ),
          )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildExpand(this.titleofdraw);
  }
}
