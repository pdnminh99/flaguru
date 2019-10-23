// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Widget getLoginView() {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Google Sign-in"),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               onPressed: () {
                // this.auth.handleSignIn().then((FirebaseUser user) {
                //   return this.auth.getCurrentUser();
                // }).then((user) {
                //   setState(() {
                //     this._currentUser = user.name.toString();
                //   });
                // }).catchError((e) => print(e));
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(
//                     Icons.favorite,
//                   ),
//                   Text("Login using Google account"),
//                 ],
//               ),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 this.auth.signOut().then((_) {
//                   return this.auth.getCurrentUser();
//                 }).then((user) {
//                   setState(() {
//                     this._currentUser = user.toString();
//                   });
//                 }).catchError((err) => print(err));
//               },
//               child: Text("Sign out"),
//             ),
//             RaisedButton(
//               onPressed: () {
//                 this.auth.switchUser().then((_) {
//                   return this.auth.getCurrentUser();
//                 }).then((user) {
//                   setState(() {
//                     this._currentUser = user.name.toString();
//                   });
//                 }).catchError((err) => print(err));
//                 print(this._currentUser);
//               },
//               child: Text("Switch User"),
//             ),
//             Container(
//               child: Text("${this._currentUser}"),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   _MyAppState() {
//     this.auth.getCurrentUser().then((user) {
//       setState(() {
//         this._currentUser = user.name.toString();
//       });
//     });
//   }

//   var auth = Authentication();
//   String _currentUser;

//   @override
//   Widget build(BuildContext ctx) {
//     return getLoginView();
//   }
// }