import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class DiffBestResultRowTutorial extends StatefulWidget {
  DiffBestResultRowTutorial(this._highestscorekey, this._turnloopkey);
    final GlobalKey _highestscorekey; 
    final GlobalKey _turnloopkey;
  
  @override
  _DiffBestResultRowStateTutorial createState() => _DiffBestResultRowStateTutorial();
}

class _DiffBestResultRowStateTutorial extends State<DiffBestResultRowTutorial> {
  var score = '145';
  var repeat = '3';
  
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    final color = Colors.black54;
    final style = TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[          
          Showcase(
            key: widget._highestscorekey,
            title: "Your highest in this level",
            titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            description: "Tap anywhere to continue",
            descTextStyle: TextStyle(fontSize: 15),
                      child: Row(
              children: <Widget>[
                Icon(Icons.star_border, color: color),
                const SizedBox(width: 10),
                Text(score, style: style),
              ],
            ),
          ),
          Showcase(
            key: widget._turnloopkey,
            title: "Your replay in this level" ,
            titleTextStyle: TextStyle (fontSize: 16, fontWeight:  FontWeight.bold), 
            description: "Touch anywhere to continue",
            descTextStyle: TextStyle(fontSize: 15),
            child:
          Row(
            children: <Widget>[
              Icon(Icons.loop, color: color),
              const SizedBox(width: 10),
              Text(repeat, style: style),
            ],
          ),),
        ],
      ),
    );
  }
}