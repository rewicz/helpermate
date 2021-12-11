import 'package:flutter/material.dart';
import 'package:helpermate/pages/needer/helpingPlanNeederPanel.dart';
import 'package:helpermate/pages/needer/needHelpNeederPanel.dart';
import 'package:helpermate/pages/needer/profileNeederPanel.dart';
import 'package:helpermate/services/userSecureStorage.dart';
import 'package:helpermate/pages/settingsPage.dart';

class NeederPanel extends StatefulWidget {
  final Function onSignOut;

  NeederPanel({required this.onSignOut});


  @override
  _NeederPanelState createState() => _NeederPanelState();
}

class _NeederPanelState extends State<NeederPanel> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
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

  final controllerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await UserSecureStorage.getFullname().then((value) =>
        setState(() {
          controllerName.text = value!;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      endDrawer: SettingPage(
        onSignOut: widget.onSignOut,
      ),
      appBar: AppBar(
        title: Text('Witaj: ' + controllerName.text),
        actions: [
          Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(Icons.settings)))
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
        onTap: _onItemTapped,
      ),
    );
  }
}
