import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/data/helpTypes.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/data/helpObject.dart';
import 'package:helpermate/data/needer.dart';

import 'neederCardScreen.dart';

class ArchiveHelpingPlan extends StatefulWidget {

  @override
  _ArchiveHelpingPlanState createState() => _ArchiveHelpingPlanState();
}

class _ArchiveHelpingPlanState extends State<ArchiveHelpingPlan> {

 // static Helper me = Helper(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001), range: 10);
  //static Needer him = Needer(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001));


  List<HelpObject> helpingList = <HelpObject> [
    //HelpObject(helper: me, helpingTime: DateTime(2020), helpType: HelpType.compan, needer: him),
    //HelpObject(helper: me, helpingTime: DateTime(2020), helpType: HelpType.compan, needer: him),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archiwum'),
        actions: [EasyDynamicThemeAutoSwitch()],
      ),
      body: ListView.builder(
          itemCount: helpingList.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => NeederCardScreen(helpObject: helpingList[index]))
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(helpingList[index].helpType.getPath),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(helpingList[index].helpingTime.toString().substring(0, 11)),
                      Text(helpingList[index].needer.fullName)
                    ],
                  )

              ),

            );
          }
      ),

    );
  }
}
