import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:helpermate/components/helper/availiabilityHelperPanel.dart';
import 'package:helpermate/components/helper/helpingPlanHelperPanel.dart';
import 'package:helpermate/components/helper/offeredHelpHelperPanel.dart';
import 'package:helpermate/components/helper/profileHelperPanel.dart';

class HelperPanel extends StatefulWidget {
  const HelperPanel({Key? key}) : super(key: key);

  @override
  State<HelperPanel> createState() => HelperPanelState();
}

/// This is the private State class that goes with MyStatefulWidget.
class HelperPanelState extends State<HelperPanel> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HelpingPlanHelperPanel(
      id: 5,
    ),
    AvailiabilityHelperPanel(

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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text('Helper'),
        actions: [EasyDynamicThemeAutoSwitch()],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: 'Helping plan',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: 'Availability',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.record_voice_over_outlined),
            label: 'Offered help',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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

