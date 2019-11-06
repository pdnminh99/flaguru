import 'package:flaguru/models/Authenticator.dart';
import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/LocalStorage.dart';
import 'package:flaguru/models/RoundDetails.dart';
import 'package:flaguru/models/User.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/widgets/background_info.dart';
import 'package:flaguru/widgets/button_switch_info.dart';
import 'package:flutter/material.dart';
import 'package:flaguru/models/ProfileProvider.dart';

class InfoScreen extends StatefulWidget {
  static String routeName = "/info_screen";
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  RoundDetails easyDetails ;
  RoundDetails normalDetails ;
  RoundDetails hardDetails ;
  String totalScore;
  
  //pro
  var auth = Authentication();
  User _currentUser;

  //get score
  Future _getScore() async
  {
    this.easyDetails =  await ProfileProvider().getLocalResult(Difficulty.EASY);
    this.normalDetails = await ProfileProvider().getLocalResult(Difficulty.NORMAL);
    this.hardDetails = await ProfileProvider().getLocalResult(Difficulty.HARD);
    this.totalScore = await LocalStorage().getTotalScore();
  }
  //ctor
  _InfoScreenState()  {
    //
   _getScore();
   //
    this.auth.getCurrentUser().then((user) {
      setState(() {
        this._currentUser = user;
        this._currentUser.email =
            user.email[0].toUpperCase() + user.email.substring(1);
      });
    });
  }
  //meth
  void signout(BuildContext context) {
    // Navigator.pushNamed(context, MenuScreen.routeName);
    // Navigator.pop(context);
    this.auth.signOut().then((_) {}).catchError((err) => print(err));
    Navigator.popAndPushNamed(context, MenuScreen.routeName);
  }

  void backMenuScreen() {
    Navigator.popAndPushNamed(context, MenuScreen.routeName);
  }

  void switchuser() {
    this.auth.switchUser().then((_) {
      return this.auth.getCurrentUser();
    }).then((user) {
      setState(() {
        this._currentUser = user;
      });
    }).catchError((err) => print(err));
    print(this._currentUser);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    print(_height);
    print(_width);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  height: _height * 0.232,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      BackgroundInfo(),
                      Positioned(
                        top: _height * 0.03,
                        left: _height * 0.02,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                          onPressed: () {
                            backMenuScreen();
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 1),
                        child: Container(
                          //margin: EdgeInsets.only(top: 50),
                          height: _height * 0.1709,
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  this._currentUser.avatar,
                                  height: _height * 0.11,
                                  width: _height * 0.11,
                                  repeat: ImageRepeat.noRepeat,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                _currentUser.name,
                                style: TextStyle(
                                    fontSize: _height * 0.0273,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                // double paddingvl = _height*0.04;
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                child: Column(
                  children: <Widget>[
                    //ProgressUser(),
                    // InfoUser(
                    //   name: _currentUser.name,
                    //   email: _currentUser.email,
                    //   score: '100',
                    // ),
                    getTotalScore(_height),
                    SizedBox(height: _height * 0.05),
                    getScroreUserCard(
                        'Easy',
                        this.easyDetails.playedCount.toString(),
                        this.easyDetails.highestScore.toString(),
                        this.easyDetails.winningCount.toString(),
                        _height),
                    SizedBox(height: _height * 0.04),
                    getScroreUserCard(
                        'Medium',
                        this.normalDetails.playedCount.toString(),
                        this.normalDetails.highestScore.toString(),
                        this.normalDetails.winningCount.toString(),
                        _height),
                    SizedBox(height: _height * 0.04),
                    getScroreUserCard(
                        'Hard',
                        this.hardDetails.winningCount.toString(),
                        this.hardDetails.winningCount.toString(),
                        this.hardDetails.winningCount.toString(),
                        _height),
                    SizedBox(height: _height * 0.04),
                    getScroreUserCard(
                        'Enless',
                        this.easyDetails.playedCount.toString(),
                        this.easyDetails.highestScore.toString(),
                        this.easyDetails.winningCount.toString(),
                        _height),
                    ButtonSwitchButtonLogout(
                        signout: signout,
                        switchuser: switchuser,
                        paramcontext: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getColodiff(String diff){
    if(diff == "Easy") 
    return Color.fromRGBO(210, 155, 111, 1);
    else if (diff == "Medium")
    return Color.fromRGBO(222, 222, 222, 1);
    else if (diff == "Hard") 
    return Color.fromRGBO(255, 193, 0, 1);
    else return Color.fromRGBO(56, 187, 231, 1);
  }

  Widget getTotalScore( double _height) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset('assets/infoscreen_icon/award.png', height: (_height * 0.067), width: (_height * 0.067),),
          Text(
            'Total Score: ',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            this.totalScore == null ? '0': this.totalScore,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

 Widget getScoreSmall(String score, double _height, String name) {
    return (Container(
      //height: _height * 0.1,
      margin: EdgeInsets.only(top: 40),
      width: _height * 0.09,
      child: Column(
        children: <Widget>[
          name == 'Rounds' ?
          Image.asset('assets/infoscreen_icon/replay.png',height: _height * 0.04, width: _height* 0.04,)
          : Image.asset('assets/infoscreen_icon/winner.png', height: _height * 0.04, width: _height * 0.04,) ,
          Padding(
            padding: EdgeInsets.all(0),
            // padding: EdgeInsets.only(top: _height * 0.005),
            child: Container(
              child: Text(
                score,
                style: TextStyle(
                    fontSize: _height * 0.039, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.00218,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: _height * 0.019),
          )
        ],
      ),
    ));
  }

  Widget getScoreHight(String score, _height) {
    return (Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          Image.asset('assets/infoscreen_icon/star.png', height: _height * 0.04, width: _height * 0.04,),
          Text(
            score,
            style: TextStyle(
                fontSize: _height * 0.039, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: _height * 0.0023,
          ),
          Text(
            'High Score',
            style: TextStyle(
                fontSize: _height * 0.019),
          ),
        ],
      ),
    ));
  }
   Widget getScroreUserCard(String diff, String rounds, String highestScore,
      String wins, double _height) {
    return (Container(
      height: _height * 0.205,
      width: double.infinity,
      decoration: BoxDecoration(
          //color: Color.fromRGBO(34, 182, 192, 1),
          color: Colors.white,
          border: Border.all(
            color: getColodiff(diff),
            style: BorderStyle.solid,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(217, 217, 217, 1),
              blurRadius: 3.0,
              offset: Offset(0, 0),
            )
          ]),
      child: Stack(
        overflow: Overflow.visible,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //name
          Positioned(
            top: _height * 0.0269 * -1,
            left: 85,
            width: _height * 0.205,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: getColodiff(diff)
              ),
              margin: EdgeInsets.only(top: 0, bottom: 6),
              alignment: Alignment.center,
              width: double.infinity,
              height: 35,
              child: Text(
                diff,
                style: TextStyle(
                    fontSize: _height * 0.031, fontWeight: FontWeight.w700),
              ),
            ),
          ),

          //Text('EASY'),
          // score
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              //height: _height *0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  getScoreSmall(rounds, _height, 'Rounds'),
                  SizedBox(
                    width: _height * 0.0068,
                  ),
                  getScoreHight(highestScore, _height),
                  SizedBox(
                    width: _height * 0.0060,
                  ),
                  getScoreSmall(rounds, _height, 'Wins'),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
