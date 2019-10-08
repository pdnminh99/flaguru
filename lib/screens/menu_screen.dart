import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Test\nMenu Screen',
              style: TextStyle(
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset('assets/images/flag-of-Vietnam.png'),
          ],
        ),
      ),
    );
  }
}
