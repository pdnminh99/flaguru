import 'package:flaguru/models/Enum.dart';
import 'package:flutter/material.dart';

class DiffBestResultRow extends StatefulWidget {
  final Difficulty diff;

  DiffBestResultRow(this.diff);

  @override
  _DiffBestResultRowState createState() => _DiffBestResultRowState();
}

class _DiffBestResultRowState extends State<DiffBestResultRow> {
  var answers = '---';
  var score = '---';

  @override
  void initState() {
    getBestResult();

    super.initState();
  }

  void getBestResult() {
    // database
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle, color: color),
              const SizedBox(width: 10),
              Text(answers,
                  style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold))
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.functions, color: color),
              const SizedBox(width: 10),
              Text(score, style: TextStyle(fontSize: 16, color: color, fontWeight: FontWeight.bold))
            ],
          ),
        ],
      ),
    );
  }
}
