import 'package:flutter/cupertino.dart';

class PlayScreenInherited extends InheritedWidget
{

  final List<GlobalKey> listkey;
  PlayScreenInherited( this.listkey, child) : super(child : child);
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  
}