import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close, color: Colors.white),
              ),
              ),
            Row(
              children: [
                Text('Theme swiitch'),
                EasyDynamicThemeAutoSwitch(),
              ],
            ),
            Row(
              children: [
                Text('Font size switch'),
                Switch(value: false, onChanged: (value) {}),
              ]
            ),
            Row(
                children: [
                  Text('Language switch'),
                  Switch(value: false, onChanged: (value) {}),
                ]
            ),
          ],
        ),
        ),
      );
  }
}
