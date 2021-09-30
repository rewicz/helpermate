import 'package:flutter/material.dart';
import 'package:helpermate/data/helpingPlanHelperData.dart';

import '../componentsUI.dart';

class OfferedHelpHelperPanel extends StatefulWidget {
  @override
  _OfferedHelpHelperPanelState createState() => _OfferedHelpHelperPanelState();
}

class _OfferedHelpHelperPanelState extends State<OfferedHelpHelperPanel> {


  List<HelpingPlanHelperData> helpingList = <HelpingPlanHelperData> [
    HelpingPlanHelperData(iDHelper: 1, iDNeeder: 2, nameHelper: "Adam", nameNeeder: "Robert", helpingTime: DateTime(2020), helpingKind: "Dog"),
    HelpingPlanHelperData(iDHelper: 1, iDNeeder: 3, nameHelper: "Adam", nameNeeder: "Monika", helpingTime: DateTime(2020), helpingKind: "Trash"),
    HelpingPlanHelperData(iDHelper: 1, iDNeeder: 4, nameHelper: "Adam", nameNeeder: "Klaudia", helpingTime: DateTime(2020), helpingKind: "Dog"),
    HelpingPlanHelperData(iDHelper: 1, iDNeeder: 4, nameHelper: "Adam", nameNeeder: "Konrad", helpingTime: DateTime(2020), helpingKind: "Trash"),
    HelpingPlanHelperData(iDHelper: 1, iDNeeder: 6, nameHelper: "Adam", nameNeeder: "Henryk", helpingTime: DateTime(2020), helpingKind: "Trash")
  ];

  late List<HelpingPlanHelperData> filterList;

  late String filterNameNeeder = 'All';
  late String filterHelpingKindNeeder = 'All';

  @override
  void initState() {
    filterList = helpingList;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if(filterNameNeeder!='All'){
      filterList = filterList.where((element) => element.nameNeeder == filterNameNeeder).toList();
      print(filterNameNeeder);
    }
    if(filterHelpingKindNeeder!='All'){
      filterList = filterList.where((element) => element.helpingKind == filterHelpingKindNeeder).toList();
      print(filterHelpingKindNeeder);

    }
    super.setState(fn);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Name: '),
              DropDownBox(
              items: ['All','Robert','Monika','Klaudia','Konrad','Henryk'],
              initValue: filterNameNeeder,
              callback: (String value) {
                filterNameNeeder = value;
              },
            ),
              Text('Helping kind: '),
              DropDownBox(
                items: ['Trash','Dog','All'],
                initValue: filterHelpingKindNeeder,
                callback: (String value) {
                  filterHelpingKindNeeder = value;
                },
              ),
            ]
        ),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              filterList = helpingList;
            });
          }, icon: Icon(Icons.search))
        ] ,
      ),
      body: ListView.builder(
          itemCount: filterList.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(filterList[index].nameHelper + "  " + helpingList[index].nameNeeder + " " +  helpingList[index].helpingKind)  ,
              ),

            );
          }
      ),
    );
  }
}
