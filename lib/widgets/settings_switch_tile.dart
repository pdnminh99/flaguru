import 'package:flutter/material.dart';

class SettingsSwitchTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final bool status;
  final Function onChange;
  final String subtitle;

  SettingsSwitchTile(
    this.title,
    this.leadingIcon,
    this.status,
    this.onChange, {
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
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
      subtitle: this.subtitle.isEmpty
          ? null
          : Padding(
              padding: EdgeInsets.only(left: 55),
              child: Text(
                this.subtitle,
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
