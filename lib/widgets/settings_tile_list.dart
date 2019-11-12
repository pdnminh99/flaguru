import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings_switch_tile.dart';
import '../models/SettingsHandler.dart';

class SettingsTileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsHandler>(context);

    return ListView(children: <Widget>[
      buildHeader(context),
      const Divider(color: Color(0x88ffffff)),
      SettingsSwitchTile(
        'Sound',
        Icons.music_note,
        settings.isSoundEnabled,
        (status) => settings.isSoundEnabled = status,
      ),
      SettingsSwitchTile(
        'Music',
        Icons.music_video,
        settings.isMusicEnabled,
        (status) => settings.isMusicEnabled = status,
      ),
      const Divider(color: Color(0x88ffffff)),
      SettingsSwitchTile(
        'Notifications',
        Icons.notifications_none,
        false,
        (status) => {},
        subtitle: 'Display info of a flag twice a day',
      ),
    ]);
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            onPressed: Navigator.of(context).pop,
          ),
          Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
