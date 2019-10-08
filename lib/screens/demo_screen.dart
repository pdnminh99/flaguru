import 'package:flaguru/models/Country.dart';
import 'package:flaguru/models/DatabaseConnector.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class DemoScreen extends State<MyApp> {
  var countries = List<Country>();

  DemoScreen() {
    var database = DatabaseConnector();
    database.collectCountries().then((countries) {
      setState(() {
        this.countries = countries;
      });
      print("There are ${countries.length} countries retrieved");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: parseView(),
    );
  }

  Widget parseView() => Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            RaisedButton(
              child: Text("Delete all data from table"),
              onPressed: () async {
                var database = DatabaseConnector();
                await database.deleteAllData();
                var countries = await database.collectCountries();
                setState(() {
                  this.countries = countries;
                });
                print("There are ${countries.length} countries retrieved");
                for (var country in this.countries) {
                  print("${country.name}\n");
                }
              },
            ),
            ...parseImage(this.countries)
          ],
        ),
        // body: Container(
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       RaisedButton(
        //         child: Text("Delete all data from table"),
        //         onPressed: () async {
        //           var database = DatabaseConnector();
        //           database.deleteAllData();
        //           database.collectCountries().then((countries) {
        //             setState(() {
        //               this.countries = countries;
        //             });
        //             print("There are ${countries.length} countries retrieved");
        //             for (var country in this.countries) {
        //               print("${country.name}\n");
        //             }
        //           });
        //         },
        //       ),
        //       ...parseImage(this.countries),
        //     ],
        //   ),
        // ),
      );

  List<Widget> parseImage(List<Country> countries) {
    var imageParser = List<Widget>();
    for (var country in countries) {
      imageParser.add(Image.asset('${country.flag}'));
    }
    print("total widgets are ${imageParser.length}");
    return imageParser;
  }
}
