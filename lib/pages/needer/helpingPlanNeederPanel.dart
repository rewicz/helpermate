import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpermate/pages/archiveHelpingPlan.dart';
import 'package:helpermate/pages/needer/helperCardScreen.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/userSecureStorage.dart';


class HelpingPlanNeederPanel extends StatefulWidget {
  @override
  _HelpingPlanNeederPanelState createState() => _HelpingPlanNeederPanelState();
}

class _HelpingPlanNeederPanelState extends State<HelpingPlanNeederPanel> {
  bool loading = true;
  bool loading2 = true;

  @override
  void initState() {
    super.initState();
    _getHelpingList();
  }

  _getHelpingList() async {
    await UserSecureStorage.getUID().then((value) => setState(() {
          name = value!;
          loading2 = false;
        }));
    await FirebaseService().readMyHelpObject().then((value) => setState(() {
          helpingList = value!;
          loading = false;
        }));
  }

  late String name;

  List<HelpObjectOutputHelper> helpingList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: loading && loading2
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("helpObjects")
                  .where('needer', isEqualTo: name)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('ŁADOWANIE'),
                  );
                } else {
                  helpingList = [];
                  snapshot.data.docs.forEach((element) {
                    Map<String, dynamic> data = element.data();
                    List<dynamic>? helpers = data['helpers'];
                    if (data['helpState'] != HelpState.RATINGHELPER.name) {
                      helpingList.add(HelpObjectOutputHelper(
                          needer: data['needer'],
                          message: data['message'],
                          helpState: HelpState.values.firstWhere(
                              (element) => element.name == data['helpState']),
                          helpers: helpers!.cast<String>(),
                          helpingTime:
                              (data['helpingTime'] as Timestamp).toDate(),
                          helpType: HelpType.values.firstWhere(
                              (element) => element.name == data['helpType']),
                          helpingHour: data['helpingHour'],
                          id: data['id'],
                          address: data['address'],
                          distance: 0,
                          localization: GeoPoint(0, 0)));
                    }
                  });

                  return ListView.builder(
                      itemCount: helpingList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (_) => HelperCardScreen(
                                            helpObject: helpingList[index])))
                                    .then((value) => setState(() {
                                          _getHelpingList();
                                          loading = true;
                                        }));
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                    helpingList[index].helpType.getPath),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(helpingList[index]
                                      .helpingTime
                                      .toString()
                                      .substring(0, 11)),
                                  Text(helpingList[index]
                                      .helpState
                                      .getDescribeNeeder)
                                ],
                              )),
                        );
                      });
                }
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
