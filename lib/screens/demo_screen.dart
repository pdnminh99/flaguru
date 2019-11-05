import 'package:flaguru/models/RoundHandler.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DemoScreen extends State<MyApp> {
  RoundHandler roundHandler;

  @override
  void initState() {
    RoundHandler.getInstance().then((handler) {
      print('Question counter: ${handler.passedQuestions}.');
      // handler.generateQAs();
      // print(handler.question.toString());
      // handler.answers.forEach((answer) => print(answer.toString()));
    }).catchError((error) => print(error));
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
        body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[]),
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
