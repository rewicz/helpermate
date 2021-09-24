import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {

  MyAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MyAppBar createState() => _MyAppBar();
}

class _MyAppBar extends State<MyAppBar> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(centerTitle: true, title: Text("sad"), actions: [
      EasyDynamicThemeBtn(
            ),
      Text("cps"),
    ]);
  }
}