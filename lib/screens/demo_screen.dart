import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/models/RoundHandler.dart';
import 'package:flaguru/models/SettingsHandler.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  static final routeName = '/demo_screen';

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  RoundHandler roundHandler;
  SettingsHandler settings;
  String logString = '';
  bool isFinish = false;

  @override
  void initState() {
    RoundHandler.getInstance(
            level: Difficulty.EASY,
            isFirstAnswerAlwaysRight: true,
            lifeCount: 100)
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
          // Text('${roundHandler.question.toString()}'),
          // Text('${roundHandler.answers.toString()}'),
          ...selection(),
          resultSection(),
          RaisedButton(
            child: Text('Reset'),
            onPressed: () {
              RoundHandler.getInstance(
                      level: Difficulty.HARD,
                      isFirstAnswerAlwaysRight: true,
                      lifeCount: 100)
                  .then((handler) {
                setState(() {
                  logString = '';
                  roundHandler = handler;
                  isFinish = false;
                });
              });
            },
          ),
          // RaisedButton(
          //   child: Text('Delete logs'),
          //   onPressed: () {
          //     _sqliteDatabase.deleteLogs().then((_) {
          //       return _sqliteDatabase.readLogs();
          //     }).then((logs) {
          //       setState(() {
          //         logString = logs;
          //       });
          //     }).catchError((error) => print(error));
          //   },
          // ),
          // RaisedButton(
          //   child: Text('Get logs'),
          //   onPressed: () {
          //     _sqliteDatabase.readLogs().then((logs) {
          //       setState(() {
          //         logString = logs;
          //       });
          //     });
          //   },
          // ),
          // RaisedButton(
          //   child: Text('Get result'),
          //   onPressed: () => setState(() => isFinish = true),
          // ),
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

  Widget resultSection() {
    if (!isFinish) return Text('No result.');
    return Text(
        'Result >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n${roundHandler.getResult()}\n$logString\n');
  }

  List<Widget> selection() {
    var buttons = List<Widget>();
    roundHandler.answers.forEach((answer) {
      buttons.add(RaisedButton(
        child: Text('${answer.country}'),
        onPressed: () {
          roundHandler.verifyAnswer(timeLeft: 8, answer: answer);
          setState(() {
            roundHandler.generateQAs();
          });
        },
      ));
    });
    return buttons;
  }

  Widget emptyCollection() => Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Container(
          child: Text('Loading'),
        ),
      );
}
