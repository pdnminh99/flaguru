//import 'package:flaguru/models/SettingsHandler.dart';
//import 'package:flutter/material.dart';
//import '../main.dart';
//
//class DemoScreen extends State<MyApp> {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData.light(),
//      home: parseCollectionToListView(),
//    );
//  }
//
//  Widget state(String text, bool isTrue) =>
//      isTrue ? Text("$text ON") : Text("$text OFF");
//
//  Widget parseCollectionToListView() {
//
//  }
  // Widget parseCollectionToListView() => Scaffold(
  //       appBar: AppBar(
  //         title: Text("Test"),
  //       ),
  //       body: ListView(
  //         padding: const EdgeInsets.all(8),
  //         children: <Widget>[
  //           RaisedButton(
  //             child: Text("Queries"),
  //             onPressed: () async {
  //               var sharedPreferences = LocalStorage();
  //               var newSettings =
  //                   await sharedPreferences.getExistingSettings(null);
  //               if (newSettings != null) {
  //                 setState(() {
  //                   this.settings = newSettings;
  //                 });
  //               }
  //             },
  //           ),
  //           RaisedButton(
  //             child: state("Audio", this.settings.isAudioON),
  //             onPressed: () async {
  //               setState(() {
  //                 this.settings.isAudioON = !this.settings.isAudioON;
  //               });
  //               var sharedPreferences = LocalStorage();
  //               await sharedPreferences.updateNewSettings(this.settings);
  //             },
  //           ),
  //           RaisedButton(
  //             child: state("Sound", this.settings.isSoundON),
  //             onPressed: () async {
  //               setState(() {
  //                 this.settings.isSoundON = !this.settings.isSoundON;
  //               });
  //               var sharedPreferences = LocalStorage();
  //               await sharedPreferences.updateNewSettings(this.settings);
  //             },
  //           ),
  //           RaisedButton(
  //             child: state("Skip tutorials", this.settings.skipTutorials),
  //             onPressed: () async {
  //               setState(() {
  //                 this.settings.skipTutorials = !this.settings.skipTutorials;
  //               });
  //               var sharedPreferences = LocalStorage();
  //               await sharedPreferences.updateNewSettings(this.settings);
  //             },
  //           )
  //         ],
  //       ),
  //     );
//}
