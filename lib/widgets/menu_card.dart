import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Function onpress;
  String _name_button;
  IconData icon_main;
  String icon_G;
  BuildContext context_param;
  Menu(this.onpress, this.icon_main, this._name_button, this.icon_G,
      this.context_param);

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
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          onPressed: () {
            onpress(context_param);
          },
          padding: EdgeInsets.all(0),
          color: Color.fromRGBO(255, 255, 255, 1),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      //color: Color.fromRGBO(250, 250, 250, 0.9),
                      color: Color.fromRGBO(240, 240, 240, 1),
                      offset: Offset(0, 2.0),
                      blurRadius: 1.0)
                ]),
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(
                  icon_main,
                  size: 35,
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
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Expanded(
                flex: 1,
                child: icon_G == null
                    ? SizedBox(
                        width: 30,
                      )
                    : Container(
                        width: 30,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                left:
                                    BorderSide(color: Colors.black, width: 2))),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("./assets/icon/search.png"),
                                  fit: BoxFit.scaleDown),
                            ),
                          ),
                        )),
              )
              //SizedBox(width: 30,)
              //child: Icon(Sword.swords, size: 35,),),
            ]),
          )),
    );
  }
}
