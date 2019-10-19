import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          Text(
//            'Drawing flags...',
//            style: TextStyle(
//              fontSize: 20,
//              fontWeight: FontWeight.bold,
//              color: Colors.white,
//            ),
//          ),
//          const SizedBox(
//            height: 25,
//          ),
          SpinKitCubeGrid(
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
