import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpermate/pages/archiveHelpingPlan.dart';
import 'package:helpermate/pages/helper/neederCardScreen.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/firebaseService.dart';

class HelpingPlanHelperPanel extends StatefulWidget {
  @override
  _HelpingPlanHelperPanelState createState() => _HelpingPlanHelperPanelState();
}

class _HelpingPlanHelperPanelState extends State<HelpingPlanHelperPanel> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getHelpingList();
  }

  _getHelpingList() async {
    await FirebaseService().readMyHelpObject().then((value) => setState(() {
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
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
          : ListView.builder(
              itemCount: helpingList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => NeederCardScreen(
                                    helpObject: helpingList[index])))
                            .then((value) => setState(() {
                                  _getHelpingList();
                                  loading = true;
                                }));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage(helpingList[index].helpType.getPath),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(helpingList[index]
                              .helpingTime
                              .toString()
                              .substring(0, 11)),
                          Text(helpingList[index].helpState.getDescribeHelper)
                        ],
                      )),
                );
              }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => ArchiveHelpingPlan()));
        },
        label: Text("Archiwum"),
        icon: Icon(Icons.archive),
      ),
    );
  }
}
