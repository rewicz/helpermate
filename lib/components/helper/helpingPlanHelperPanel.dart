import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpermate/components/archiveHelpingPlan.dart';
import 'package:helpermate/data/helpObjectInput.dart';
import 'package:helpermate/data/helpObjectOutputHelper.dart';
import 'package:helpermate/data/helpTypes.dart';
import 'package:helpermate/firebase/services/firebaseService.dart';
import '../neederCardScreen.dart';

class HelpingPlanHelperPanel extends StatefulWidget {

  @override
  _HelpingPlanHelperPanelState createState() => _HelpingPlanHelperPanelState();
}

class _HelpingPlanHelperPanelState extends State<HelpingPlanHelperPanel> {

  //static Helper me = Helper(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001),  range: 2);
  //static Needer him = Needer(email: 'email@email.com', address: 'Glwice Soltysowa 10', fullName: 'Adaam Fertes', telephone: '123654321', dateOfBirth: DateTime(2001), );
  bool loading = true;

  @override
  void initState() {

    super.initState();
    _getHelpingList();
  }
  _getHelpingList() async {
    await FirebaseService().readHelpObjectHelper().then((value) =>  setState(() {
      helpingList = value!;
      loading = false;
    }));
  }

  List<HelpObjectOutputHelper> helpingList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: loading
          ? CircularProgressIndicator()
          : ListView.builder(
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
                      Text(helpingList[index].distance.toString() + ' (km)')
                    ],
                  )

                ),

              );
            }
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => ArchiveHelpingPlan())
          );
        },
        label: Text("Archiwum"),
        icon: Icon(Icons.archive),
      ),

    );
  }
}
