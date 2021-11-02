import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/services/authService.dart';

class SettingPage extends StatefulWidget {
  final Function onSignOut;

  SettingPage({required this.onSignOut});


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
                Text('Zmiana kolorystyki'),
                EasyDynamicThemeSwitch(),
              ],
            ),
            RoitButton(text: 'Wyloguj', onPressedCallback: () {
              Navigator.pop(context);
              Navigator.pop(context);
              AuthService().signOut();
              widget.onSignOut();

            })
          ],
        ),
        ),
      );
  }
}
