import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final bool isAnswered;
  final bool isOver;
  final Function onRefresh;
  final Function onOver;

  BottomBar({
    @required this.isAnswered,
    @required this.isOver,
    @required this.onRefresh,
    @required this.onOver,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isAnswered)
              SizedBox(
                height: constraint.maxHeight * 0.7,
                width: constraint.maxWidth * 0.2,
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.white,
                  onPressed: (isOver) ? onOver : onRefresh,
                  child: Icon(
                    (isOver) ? Icons.airplay : Icons.arrow_forward,
                    size: constraint.maxHeight * 0.55,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
