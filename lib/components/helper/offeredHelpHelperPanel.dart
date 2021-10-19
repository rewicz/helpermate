import 'package:flutter/material.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/data/helpingPlanHelperData.dart';
import 'package:helpermate/data/needer.dart';

import '../componentsUI.dart';

class OfferedHelpHelperPanel extends StatefulWidget {
  @override
  _OfferedHelpHelperPanelState createState() => _OfferedHelpHelperPanelState();
}

class _OfferedHelpHelperPanelState extends State<OfferedHelpHelperPanel> {


  static Helper me = Helper(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001), password: 'dsa', iD: 1);
  static Needer him = Needer(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001), password: 'dsa', iD: 1);


  List<HelpObject> helpingList = <HelpObject> [
    HelpObject(helper: me, helpingTime: DateTime(2020), helpingKind: "Dog", needer: him),
    HelpObject(helper: me, helpingTime: DateTime(2020), helpingKind: "Sleep", needer: him),
  ];


  late List<HelpObject> filterList = helpingList;

  late String filterNameNeeder = 'All';
  late String filterHelpingKindNeeder = 'All';

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context)
    {
      return AlertDialog(
        content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Name: '),
              DropDownBox(
                items: [
                  'All',
                  'Robert',
                  'Monika',
                  'Klaudia',
                  'Konrad',
                  'Henryk'
                ],
                initValue: filterNameNeeder,
                callback: (String value) {
                  filterNameNeeder = value;
                },
              ),
              Text('Helping kind: '),
              DropDownBox(
                items: ['Trash', 'Dog', 'All'],
                initValue: filterHelpingKindNeeder,
                callback: (String value) {
                  filterHelpingKindNeeder = value;
                },
              ),
            ]
        ),
      );
    });
  }


  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RoitButton(text: "Filtruj", onPressedCallback: () {showChoiceDialog(context);}),

        actions: [
          IconButton(onPressed: () {
            setState(() {
              filterList = helpingList;
            });
          }, icon: Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
          itemCount: filterList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(""),
              ),

            );
          }
      ),
    );
  }
}
