import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String difficulty;

  TopBar({
    @required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  difficulty.toUpperCase(),
                  style: TextStyle(
                    fontSize: constraint.maxHeight * 0.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.8,
                width: constraint.maxHeight * 1.1,
                child: FlatButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.more_horiz,
                    size: constraint.maxHeight * 0.5,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
