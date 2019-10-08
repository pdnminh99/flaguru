import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final bool isAnswered;
  final Function onRefresh;

  BottomBar({
    @required this.isAnswered,
    @required this.onRefresh,
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
                  onPressed: onRefresh,
                  child: Icon(
                    Icons.arrow_forward,
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
