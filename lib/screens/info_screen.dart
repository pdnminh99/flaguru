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
  List<RoundDetails> _profileDetails;
  int _totalScore = 0;
  ProfileProvider _profileInstance;
  Authentication _authenticator;
  User _currentUser;

  Future<List<RoundDetails>> _getLocalResult() => Future.wait([
        _profileInstance.getLocalResult(Difficulty.EASY),
        _profileInstance.getLocalResult(Difficulty.NORMAL),
        _profileInstance.getLocalResult(Difficulty.HARD),
        _profileInstance.getLocalResult(Difficulty.ENDLESS),
      ]);

  Future<void> _getScore() => _getLocalResult().then((result) {
        setState(() {
          _profileDetails = result;
        });
        return LocalStorage.getTotalScore();
      }).then((score) {
        setState(() {
          _totalScore = score;
        });
      });

  @override
  void initState() {
    _profileInstance = ProfileProvider();
    _authenticator = Authentication();
    _profileDetails = List<RoundDetails>();
    Future.wait([
      _authenticator.getCurrentUser().then((user) {
        setState(() {
          _currentUser = user;
          _currentUser.email =
              user.email[0].toUpperCase() + user.email.substring(1);
        });
      }),
      _getScore(),
    ]);
    super.initState();
  }

  void signOut(BuildContext context) => _authenticator
      .signOut()
      .then((_) => _navigateToMenuScreen())
      .catchError((err) => print(err));

  void _navigateToMenuScreen() {
    Navigator.of(context).pushReplacementNamed(MenuScreen.routeName);
  }

  void switchUser() => _authenticator
          .switchUser()
          .then((_) => this._authenticator.getCurrentUser())
          .then((user) {
        setState(() => _currentUser = user);
      }).catchError((err) => print(err));

  Widget _profileBackButton(double _height) => Positioned(
        top: _height * 0.03,
        left: _height * 0.02,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            _navigateToMenuScreen();
          },
        ),
      );

  Widget _profilePicture(double height) => _currentUser?.avatar != null
      ? Image.network(
          _currentUser.avatar,
          height: height * 0.10,
          width: height * 0.10,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover,
        )
      : Image.asset('assets/images/blankavatar.png',
          height: height * 0.10,
          width: height * 0.10,
          repeat: ImageRepeat.noRepeat,
          fit: BoxFit.cover);

  Widget _profileHeader(double height) => Container(
      height: height * 0.232,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          BackgroundInfo(),
          _profileBackButton(height),
          Align(
            alignment: Alignment(0, 1.2),
            child: Container(
              height: height * 0.1709,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: _profilePicture(height),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    _currentUser?.name ?? '...Loading',
                    style: TextStyle(
                        fontSize: height * 0.0273, fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ),
        ],
      ));

  Widget _profileBody(double _height, double _width) => Padding(
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
        child: Column(
          children: <Widget>[
            getTotalScore(_height),
            for (var round in _profileDetails) ...[
              SizedBox(height: _height * 0.05),
              _getScoreUserCard(round, _height, _width),
            ],
            ButtonSwitchButtonLogout(
                signOut,
                switchUser,
                ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _profileHeader(_height),
              _profileBody(_height, _width),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColodiff(Difficulty diff) {
    switch (diff) {
      case Difficulty.EASY:
        return Color.fromRGBO(210, 155, 111, 1);
      case Difficulty.NORMAL:
        return Color.fromRGBO(222, 222, 222, 1);
      case Difficulty.HARD:
        return Color.fromRGBO(255, 193, 0, 1);
      default:
        return Color.fromRGBO(56, 187, 231, 1);
    }
  }

  Widget getTotalScore(double _height) {
    return Container(
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/infoscreen_icon/award.png',
            height: (_height * 0.063),
            width: (_height * 0.063),
          ),
          Text(
            'Total Score: ',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$_totalScore',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _getScoreIcon(ScoreType type, double height) {
    switch (type) {
      case ScoreType.HighestScore:
        return Image.asset(
          'assets/infoscreen_icon/star.png',
          height: height * 0.04,
          width: height * 0.04,
        );
      case ScoreType.RoundsCount:
        return Image.asset(
          'assets/infoscreen_icon/replay.png',
          height: height * 0.04,
          width: height * 0.04,
        );
      default:
        return Image.asset(
          'assets/infoscreen_icon/winner.png',
          height: height * 0.04,
          width: height * 0.04,
        );
    }
  }

  Widget _scoreTypeString(ScoreType type, double height, bool isPluralNouns) {
    switch (type) {
      case ScoreType.HighestScore:
        return Text(
          'Best Score',
          style: TextStyle(fontSize: height * 0.019),
        );
      case ScoreType.RoundsCount:
        return Text(
          'Round${isPluralNouns ? 's' : ''}',
          style: TextStyle(fontSize: height * 0.019),
        );
      default:
        return Text(
          'Win${isPluralNouns ? 's' : ''}',
          style: TextStyle(fontSize: height * 0.019),
        );
    }
  }

  Widget _getScoreRepresentation(int score, double height, ScoreType type) =>
      (Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: <Widget>[
            _getScoreIcon(type, height),
            Text(
              '$score',
              style: TextStyle(
                  fontSize: height * 0.039, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: height * 0.0023,
            ),
            _scoreTypeString(type, height, score > 1),
          ],
        ),
      ));

  String _getDifficultyStringMap(Difficulty level) {
    switch (level) {
      case Difficulty.EASY:
        return 'Easy';
      case Difficulty.NORMAL:
        return 'Normal';
      case Difficulty.HARD:
        return 'Hard';
      default:
        return 'Endless';
    }
  }

  Widget _cardHeader(double height, width, RoundDetails details) => Align(
        alignment: Alignment(0, -1.4),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: _getColodiff(details.level)),
          margin: EdgeInsets.only(top: 0, bottom: 6),
          alignment: Alignment.center,
          width: width * 0.35,
          height: 35,
          child: Text(
            _getDifficultyStringMap(details.level),
            style: TextStyle(
                fontSize: height * 0.031, fontWeight: FontWeight.w700),
          ),
        ),
      );

  Widget _cardBody(double height, width, RoundDetails details) => Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _getScoreRepresentation(
                  details.playedCount, height, ScoreType.RoundsCount),
              SizedBox(
                width: height * 0.0068,
              ),
              _getScoreRepresentation(
                  details.highestScore, height, ScoreType.HighestScore),
              if (details.level != Difficulty.ENDLESS) ...[
                SizedBox(
                  width: height * 0.0060,
                ),
                _getScoreRepresentation(
                    details.winningCount, height, ScoreType.WinningCount),
              ],
            ],
          ),
        ),
      );

  BoxDecoration _scoreCardDecoration(RoundDetails details) => BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: _getColodiff(details.level),
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
          ]);

  Widget _getScoreUserCard(RoundDetails details, double height, width) {
    return (Container(
      height: height * 0.205,
      width: double.infinity,
      decoration: _scoreCardDecoration(details),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          _cardHeader(height, width, details),
          _cardBody(height, width, details),
        ],
      ),
    ));
  }
}
