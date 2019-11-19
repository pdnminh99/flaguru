import 'package:flutter/material.dart';

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
    return Container();
  }
}

class Resulttutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TutorialScreen extends StatefulWidget {
  static String routeName = "./tutorial_screen";
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {
  static var tutorialPage = <Widget>[
    new Menututorial(),
    new Difftutorial(),
    new Playtutorial(),
    new Resulttutorial()
  ];
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: tutorialPage.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff019dad),
        centerTitle: true,
        title: Text(
          'Tutorial',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, "/");
          },
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: _height * 0.922,
                child: TabBarView(
                  controller: tabController,
                  children: tutorialPage,
                ),
              ),
              // TabPageSelector(
              //   controller: tabController,
              //   indicatorSize: 13,
              //   selectedColor: Color(0xff019dad),
              // ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              color: Color(0xff019dad),
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                print(tabController.index);
                print(tutorialPage.length);
                if (tabController.index != tutorialPage.length - 1) {
                  tabController.animateTo(tabController.index + 1);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
