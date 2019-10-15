import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final Function onStart;

  StartButton({this.onStart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 150,
        child: RaisedButton(
          elevation: 5,
          color: Colors.white,
          onPressed: onStart,
          child: Text(
            'START',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
