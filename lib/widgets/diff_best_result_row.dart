import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/ProfileProvider.dart';
import 'package:flutter/material.dart';

class DiffBestResultRow extends StatefulWidget {
  final Difficulty diff;

  DiffBestResultRow(this.diff);

  @override
  _DiffBestResultRowState createState() => _DiffBestResultRowState();
}

class _DiffBestResultRowState extends State<DiffBestResultRow> {
  var score = '--';
  var repeat = '--';

  @override
  void initState() {
    getUserResult();
    super.initState();
  }

  void getUserResult() {
    ProfileProvider().getLocalResult(widget.diff).then((details) => setState(() {
          score = details.highestScore.toString();
          repeat = details.playedCount.toString();
        }));
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
          Row(
            children: <Widget>[
              Icon(Icons.star_border, color: color),
              const SizedBox(width: 10),
              Text(score, style: style),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.loop, color: color),
              const SizedBox(width: 10),
              Text(repeat, style: style),
            ],
          ),
        ],
      ),
    );
  }
}
