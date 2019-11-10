import 'dart:io';

import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/RoundHandler.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DemoScreen extends State<MyApp> {
  RoundHandler roundHandler;

  @override
  void initState() {
    RoundHandler.getInstance(
            level: Difficulty.NORMAL, isFirstAnswerAlwaysRight: true)
        .then((handler) {
      setState(() => roundHandler = handler);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: this.roundHandler == null
          ? this.emptyCollection()
          : this.parseCollectionToListView(),
    );
  }

  Widget parseCollectionToListView() => Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
          Text('Question passed ${roundHandler.passedQuestions}'),
          Text('${roundHandler.question.toString()}'),
          Text('${roundHandler.answers.toString()}'),
          RaisedButton(
            child: Text('Generate'),
            onPressed: () => setState(() => roundHandler.generateQAs()),
          ),
          RaisedButton(
              child: Text('Generate 50 questions'),
              onPressed: () {
                for (var i = 0; i < 50; i++) {
                  roundHandler.generateQAs();
                }
                setState(() => roundHandler.generateQAs());
              }),
          Text('${roundHandler.toString()}'),
        ]),
      );

  Widget emptyCollection() => Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Container(
          child: Text('Loading'),
        ),
      );
}
