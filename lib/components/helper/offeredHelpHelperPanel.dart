import 'package:flutter/material.dart';
import 'package:helpermate/data/helpTypes.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/data/helpObject.dart';
import 'package:helpermate/data/needer.dart';

import '../componentsUI.dart';

class OfferedHelpHelperPanel extends StatefulWidget {
  @override
  _OfferedHelpHelperPanelState createState() => _OfferedHelpHelperPanelState();
}

class _OfferedHelpHelperPanelState extends State<OfferedHelpHelperPanel> {
  static Helper me = Helper(
      email: 'email@email.com',
      address: 'Glwice Soltysowa 10',
      fullName: 'Adaam Fertes',
      telephone: '123654321',
      dateOfBirth: DateTime(2001),
      password: 'dsa',
      ID: 1, range: 20);
  static Needer him = Needer(
      email: 'email@email.com',
      address: 'Glwice Soltysowa 10',
      fullName: 'Adaam Fertes',
      telephone: '123654321',
      dateOfBirth: DateTime(2001),
      password: 'dsa',
      ID: 1);

  List<HelpObject> helpingList = <HelpObject>[
    HelpObject(
        helper: me,
        helpingTime: DateTime(2020),
        helpType: HelpType.compan,
        needer: him),
    HelpObject(
        helper: me,
        helpingTime: DateTime(2020),
        helpType: HelpType.computer,
        needer: him),
  ];

  late List<HelpObject> filterList = helpingList;

  late String filterNameNeeder = 'All';
  late String filterHelpingKindNeeder = 'All';

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wybierz filtry'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    children: [
                      Text('Rodzaj: '),
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
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: DataPickerBox(text: 'Od', callback: (value) {}))
                  ]),
                  Row(children: [
                    Expanded(
                        child: DataPickerBox(text: 'Do', callback: (value) {}))
                  ]),
                  Row(children: [
                    RoitButton(text: 'Szukaj', onPressedCallback: () {}),
                    RoitButton(text: 'Anuluj', onPressedCallback: () {}),
                  ]),
                ],
              ),
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
        title: RoitButton(
            text: "Filtruj",
            onPressedCallback: () {
              showChoiceDialog(context);
            }),
        actions: [
          IconButton(
            tooltip: 'Wyczyśc filtry',
              onPressed: () {
                setState(() {
                  filterList = helpingList;
                });
              },
              icon: Icon(Icons.clear))
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
          }),
    );
  }
}
