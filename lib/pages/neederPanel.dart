import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/needer/helpingPlanNeederPanel.dart';
import 'package:helpermate/components/needer/needHelpNeederPanel.dart';
import 'package:helpermate/components/needer/profileNeederPanel.dart';

class NeederPanel extends StatefulWidget {
  final Function onSignOut;

  NeederPanel({required this.onSignOut});


  @override
  _NeederPanelState createState() => _NeederPanelState();
}

class _NeederPanelState extends State<NeederPanel> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HelpingPlanNeederPanel(),
    NeedHelpNeederPanel(),
    ProfileNeederPanel(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Helper'),
        actions: [EasyDynamicThemeSwitch()],
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
            icon: Icon(Icons.date_range),
            label: 'Dodaj pomoc',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[100],
        onTap: _onItemTapped,
      ),
    );
  }
}
