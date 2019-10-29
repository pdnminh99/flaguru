import 'package:flaguru/models/SettingsHandler.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DemoScreen extends State<MyApp> {
  SettingsHandler settings;

  DemoScreen() {
    SettingsHandler.getInstance().then((settings) {
      setState(() {
        this.settings = settings;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: parseCollectionToListView(),
    );
  }

  Widget state(String text, bool isTrue) =>
      isTrue ? Text("$text ON") : Text("$text OFF");

  Widget parseCollectionToListView() => Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            RaisedButton(
              child: state("Audio", this.settings.isAudioEnabled),
              onPressed: () {
                setState(() {
                  this.settings.isAudioEnabled = !this.settings.isAudioEnabled;
                });
              },
            ),
            RaisedButton(
              child: state("Sound", this.settings.isSoundEnabled),
              onPressed: () {
                setState(() {
                  this.settings.isSoundEnabled = !this.settings.isSoundEnabled;
                });
              },
            ),
            RaisedButton(
              child: state("Skip tutorials", this.settings.skipTutorials),
              onPressed: () {
                setState(() {
                  this.settings.skipTutorials = !this.settings.skipTutorials;
                });
              },
            )
          ],
        ),
      );
}
