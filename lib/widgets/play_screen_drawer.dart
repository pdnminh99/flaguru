import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';

class PlayScreenDrawer extends StatelessWidget {
  final Difficulty difficulty;

  PlayScreenDrawer({
    @required this.difficulty,
  });

  void navigateToMenu(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MenuScreen.routeName);
  }

  void restart(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed(PlayScreen.routeName, arguments: difficulty);
  }

  Widget getListTile(String title, IconData leadingIcon, Function onTap) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.white),
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          color: Color(0xff019dad),
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Text(
                  'FLAGURU',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
              ),
              getListTile('Restart', Icons.refresh, () => restart(context)),
              getListTile(
                  'Main Menu', Icons.menu, () => navigateToMenu(context)),
            ],
          ),
        ),
      ),
    );
  }
}
