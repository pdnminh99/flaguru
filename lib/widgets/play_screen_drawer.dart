import 'package:flaguru/models/Enum.dart';
import 'package:flaguru/screens/menu_screen.dart';
import 'package:flaguru/screens/play_screen.dart';
import 'package:flutter/material.dart';

class PlayScreenDrawer extends StatefulWidget {
  final Difficulty difficulty;

  PlayScreenDrawer({@required this.difficulty});

  @override
  _PlayScreenDrawerState createState() => _PlayScreenDrawerState();
}

class _PlayScreenDrawerState extends State<PlayScreenDrawer> {
  bool soundEnabled = true;
  bool musicEnabled = true;

  @override
  void initState() {
    // get audio data
    super.initState();
  }

  void changeSoundStatus(bool status) {
    //update audio data
    setState(() => soundEnabled = status);
  }

  void changeMusicStatus(bool status) {
    // update audio data
    setState(() => musicEnabled = status);
  }

  void navigateToMenu(BuildContext context) {
    // need confirmation
    Navigator.of(context).pushReplacementNamed(MenuScreen.routeName);
  }

  void restart(BuildContext context) {
    // need confirmation
    Navigator.of(context).pushReplacementNamed(
      PlayScreen.routeName,
      arguments: widget.difficulty,
    );
  }

  void popUpConfirmation(Function doYes) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          color: const Color(0xff019dad),
          child: ListView(
            children: <Widget>[
              buildDrawerHeader(),
              buildListTile('Restart', Icons.refresh, () => restart(context)),
              buildListTile('Main Menu', Icons.menu, () => navigateToMenu(context)),
              const SizedBox(height: 30),
              buildSwitchTile('Sound', Icons.music_note, soundEnabled, changeSoundStatus),
              buildSwitchTile('Music', Icons.music_video, musicEnabled, changeMusicStatus),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return DrawerHeader(
      child: Center(
        child: const Text(
          'FLAGURU',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget buildListTile(String title, IconData leadingIcon, Function onTap) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.white),
      title: Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget buildSwitchTile(String title, IconData leadingIcon, bool status, Function onChange) {
    final fontSize = 20.0;
    final color = Colors.white;

    return SwitchListTile(
      title: Row(
        children: <Widget>[
          Icon(leadingIcon, size: fontSize + 5, color: color),
          const SizedBox(width: 30),
          Text(title, style: TextStyle(fontSize: fontSize, color: color)),
        ],
      ),
      value: status,
      onChanged: (val) => onChange(val),
      activeColor: Colors.tealAccent,
    );
  }
}
