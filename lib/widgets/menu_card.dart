import 'package:flaguru/widgets/Menu_Icon/menu__icon_icons.dart';
import 'package:flaguru/widgets/name_button.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Function onpress;
  String _name_button;
  IconData icon_main;
  String icon_G;
  BuildContext context_param;

  Menu(this.onpress, this.icon_main, this._name_button, this.icon_G, this.context_param);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     width: double.infinity,
    //     height: 55,
    //     decoration: BoxDecoration(
    //       color: Colors.white60,
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child:
    return SizedBox(
      height: 60,
      width: 350,
      child: RaisedButton(
          elevation: 7,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onPressed: () {
            _name_button == "Login" ? onpress() : onpress(context_param);
          },
          color: Colors.white.withOpacity(0.85),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Icon(icon_main, size: 28, color: Colors.black87),
              ),
              Expanded(
                  flex: 3,
                  child: Text(
                    _name_button,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.black87, fontSize: 26, fontWeight: FontWeight.bold),
                  )),
              Expanded(
                flex: 1,
                child: icon_G == null
                    ? const SizedBox(width: 30)
                    : Container(
                        decoration: BoxDecoration(
                            border:
                                const Border(left: BorderSide(color: Colors.black54, width: 1))),
                        child: Container(
                          margin: const EdgeInsets.all(16.0),
                          child: icon_G == 'G'
                              ? Image.asset("./assets/icon/search.png", fit: BoxFit.fill)
                              : CircleAvatar(backgroundImage: NetworkImage(icon_G)),
                        ),
                      ),
              )
              //SizedBox(width: 30,)
              //child: Icon(Sword.swords, size: 35,),),
            ]),
          )),
    );
  }
}
