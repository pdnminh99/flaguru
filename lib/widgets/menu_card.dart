import 'package:flag_quiz/icon_and_font/menu__icon_icons.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final onpress;
  String _name_button;

  var icon;
  Menu(this.onpress, this._name_button,this.icon);
  
  @override
  Widget build(BuildContext context) {
    // return Container(
    //     width: double.infinity,
    //     height: 55,
    //     decoration: BoxDecoration(
    //       color: Colors.white60,
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child: Row(children: <Widget>[
    return SizedBox(
      height: 60,
      width: 350,
      child: FlatButton(
          shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
          onPressed: onpress,
          padding: EdgeInsets.all(0),
          color: Colors.white54,
          child:
           Container(
             width: double.infinity,
             height: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               boxShadow: [
                 BoxShadow(color: Colors.white54,
                 offset: Offset(0,2.0),
                 blurRadius: 1.0)
               ]
             ),
             child: Row(children: <Widget>[
              Expanded(
                    flex: 1,
                    child: Icon(
                      Menu_Icon.swords,size: 35,
                    ),                  
                    ),
              Expanded(
                  flex: 4,
                  child: Text(
                    _name_button,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                Expanded(
                  flex: 1,
                  child: 
                    icon == null ? SizedBox(width: 30,) : Icon(Menu_Icon.swords)
                  )
                  //SizedBox(width: 30,)
                  //child: Icon(Sword.swords, size: 35,),),
                  
          ]),
           )),
    );
  }
}
