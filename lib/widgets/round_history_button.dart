import 'package:flutter/material.dart';

class RoundHistoryButton extends StatelessWidget {
  final Function showHistory;

  RoundHistoryButton({this.showHistory});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth * 0.8,
          height: constraints.maxHeight,
          child: RaisedButton(
            elevation: 5,
            padding: const EdgeInsets.all(0),
            color: const Color(0xff24b6c5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            onPressed: showHistory,
            child: Text(
              'History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.35,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        );
      },
    );
  }
}
