import 'package:flutter/material.dart';
import 'package:path/path.dart';

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
        appBar: AppBar(title: const Text('hello'),),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) => ExpandlistMenu(listoftitle[index]),
          itemCount: listoftitle.length,
        ),
      ),
      
    );
  }
}


List <TitleofDraw> listoftitle = <TitleofDraw>[
  //Play
  TitleofDraw (
    'Play',
    <TitleofDraw>[
      TitleofDraw('Difficult Screen',),
      TitleofDraw('Play Screen',),
      TitleofDraw('Result Screen',),
    ]
  ),
  //Login
  TitleofDraw(
    'Login',
  ),
  //Setting
  TitleofDraw(
    'Setting',
  )
];
class TitleofDraw {
  String titlename;
  List<TitleofDraw> titlechild ;
  //Ctor
  TitleofDraw (this.titlename, [this.titlechild = const <TitleofDraw>[]]);
}
class ExpandlistMenu extends StatelessWidget {
  
  final TitleofDraw titleofdraw;

  const ExpandlistMenu( this.titleofdraw);

  Widget _buildExpand (TitleofDraw titleparam)
  {
      if(titleparam.titlechild.isEmpty)
      return 
       ListTile(
        onTap: () => print('hello'),
        title: Text(titleparam.titlename),
        );
      else {
        return  ExpansionTile(
          initiallyExpanded: true,
          key: PageStorageKey<TitleofDraw>(titleparam),
          title: Text(titleparam.titlename), 
          children: titleparam.titlechild.map(_buildExpand).toList()
          );
      }
  }
  @override
  Widget build(BuildContext context) {
    return _buildExpand(this.titleofdraw);
  }
}
