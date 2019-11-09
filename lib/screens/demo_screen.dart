import 'dart:io';

import 'package:flaguru/models/RoundHandler.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DemoScreen extends State<MyApp> {
  RoundHandler roundHandler;

  @override
  void initState() {
    RoundHandler.getInstance().then((handler) {
      setState(() => roundHandler = handler);
    });
//      print('\n > Start generating questions until errors\n');
//      int count = 1;
//      while (true) {
//        try {
//          if (Platform.isWindows) {
//            // not tested, I don't have Windows
//            // may not to work because 'cls' is an internal command of the Windows shell
//            // not an executable
//            print(Process.runSync("cls", [], runInShell: true).stdout);
//          } else {
//            print(Process.runSync("clear", [], runInShell: true).stdout);
//          }
//          print(
//              'counter -> $count | passed -> ${handler.passedQuestions} >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
//          print(handler.toString());
//          handler.generateQAs();
//          count++;
//          if (count == 201) {
//            print('Break at 200:\n ${handler.toString()}');
//            break;
//          }
//        } catch (Exception) {
//          /*
//          -> Result found that 197 questions were generated before errors.
//           */
//          print('There are $count questions generated before errors');
//          print(handler.toString());
//          break;
//        }
//  }

//      print('Loop ended at $count');
    // handler.answers.forEach((answer) => print(answer.toString()));
//    }).catchError((error) => print(error));
    super.initState();
//    print('Init stopped;');
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
              child: Text('Generate 190 questions'),
              onPressed: () {
                for (var i = 0; i < 190; i++) {
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
