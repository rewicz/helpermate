import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/roitButton.dart';
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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    'Panel ustawień',

                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Zmiana kolorystyki'),
                  EasyDynamicThemeSwitch(),
                ],
              ),
              SizedBox(
                height: 20,
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
      ),
      );
  }
}
