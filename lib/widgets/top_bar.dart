import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String level;

  TopBar({
    @required this.level,
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
              Text(
                level.toUpperCase(),
                style: TextStyle(
                  fontSize: constraint.maxHeight * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: constraint.maxHeight * 0.8,
                width: constraint.maxHeight * 1.1,
                child: FlatButton(
                  onPressed: () {},
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
