import 'package:flaguru/widgets/tutorial_widget/menuscreen_tutorial.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD

class Menututorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Menu Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/tutorial_picture/MenuscreenPic.png",
              width: 250,
            )),
            SizedBox(
              height: 20,
            ),
        // RichText(
        //   text: TextSpan(
        //     text:'hello', 
        //     style: TextStyle(fontSize: 20, color: Colors.black)
        //   ),
        // )
      ]),
    );
  }
}

class Difftutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Different Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset("assets/tutorial_picture/DiffscreenPic.png",
          width: 250 ),
        )
      ]),
    );
  }
}


class Playtutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Play Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset("assets/tutorial_picture/PlayscreenPic.png",
          width: 250 ),
        )
      ]),
    );
  }
}

class Resulttutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Result Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset("assets/tutorial_picture/ResultscreenPic.png",
          width: 250 ),
        )
      ]),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
>>>>>>> 4b02583cd2494587cfed3ebfef92b6224112fd3c

class TutorialScreen extends StatefulWidget {
  static String routeName = "./tutorial_screen";
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
   
    super.dispose();
  }


  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
        body: ShowCaseWidget(
          builder: Builder(
            builder: (context) => MenuScreenTutorial()
          ),),);
  }

  
}
