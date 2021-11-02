import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/helper/helpingPlanHelperPanel.dart';
import 'package:helpermate/components/helper/offeredHelpHelperPanel.dart';
import 'package:helpermate/components/helper/profileHelperPanel.dart';
import 'package:helpermate/services/authService.dart';

class HelperPanel extends StatefulWidget {
  final Function onSignOut;

  HelperPanel({required this.onSignOut});

  @override
  State<HelperPanel> createState() => HelperPanelState();
}

class HelperPanelState extends State<HelperPanel> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HelpingPlanHelperPanel(
    ),
    OfferedHelpHelperPanel(
    ),
    ProfileHelperPanel(

    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
        title: const Text('Chętny do pomocy'),
        actions: [EasyDynamicThemeSwitch(), TextButton(onPressed: () {
          Navigator.pop(context);
          AuthService().signOut();
          widget.onSignOut();
        }, child: Text('logout'),)
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Plan pomocy',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over_outlined),
            label: 'Zaoferuj pomoc',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

