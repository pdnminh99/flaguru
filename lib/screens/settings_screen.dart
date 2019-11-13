import 'package:flutter/material.dart';

import '../widgets/spinning_gear.dart';
import '../widgets/settings_tile_list.dart';

class SettingsScreen extends StatelessWidget {
  static final routeName = '/settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff019dad),
      body: Stack(
        children: <Widget>[
          SettingsTileList(),
          buildBottomGear(context),
        ],
      ),
    );
  }

  Widget buildBottomGear(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return Positioned(
      bottom: 0 - size / 2.5,
      left: 0 - size / 2.5,
      child: Hero(
        tag: 'settings',
        child: SpinningGear(size: size, color: Colors.white.withOpacity(0.2)),
      ),
    );
  }
}
