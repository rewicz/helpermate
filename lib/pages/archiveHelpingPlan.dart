import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpObjectArchive.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/userSecureStorage.dart';

import 'helper/neederCardScreen.dart';

class ArchiveHelpingPlan extends StatefulWidget {
  @override
  _ArchiveHelpingPlanState createState() => _ArchiveHelpingPlanState();
}

class _ArchiveHelpingPlanState extends State<ArchiveHelpingPlan> {
  List<HelpObjectArchive> helpingList = [];
  bool loading = true;

  @override
  void initState() {
    _getArchiveList();
    super.initState();
  }

  _getArchiveList() async {
    await UserSecureStorage.getUID().then((value) {
      name = value!;
      setState(() {
        loading = false;
      });
    });
  }

  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Archiwum'),
          actions: [EasyDynamicThemeSwitch()],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('archive')
                    .where('person', isEqualTo: name)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text('Nie ma żadnych zarchiwizowancyh pomocy'),
                    );
                  } else {
                    helpingList = [];
                    snapshot.data.docs.forEach((element) {
                      Map<String, dynamic> data = element.data();
                      helpingList.add(HelpObjectArchive(
                          needer: data['needer'],
                          message: data['message'],
                          helpState: HelpState.values.firstWhere(
                              (element) => element.name == data['helpState']),
                          helper: data['helper'],
                          helpingTime:
                              (data['helpingTime'] as Timestamp).toDate(),
                          helpType: HelpType.values.firstWhere(
                              (element) => element.name == data['helpType']),
                          helpingHour: data['helpingHour'],
                          id: data['id'],
                          address: data['address'],
                          distance: 0,
                          localization: GeoPoint(0, 0)));
                    });
                    return ListView.builder(
                        itemCount: helpingList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => NeederCardScreen(
                                          helpObject:
                                              new HelpObjectOutputHelper(
                                                  needer:
                                                      helpingList[index].needer,
                                                  address: helpingList[index]
                                                      .address,
                                                  helpers: [
                                                    helpingList[index].helper
                                                  ],
                                                  id: helpingList[index].id,
                                                  helpingHour:
                                                      helpingList[index]
                                                          .helpingHour,
                                                  distance: helpingList[index]
                                                      .distance,
                                                  localization:
                                                      helpingList[index]
                                                          .localization,
                                                  message: helpingList[index]
                                                      .message,
                                                  helpState: helpingList[index]
                                                      .helpState,
                                                  helpingTime:
                                                      helpingList[index]
                                                          .helpingTime,
                                                  helpType: helpingList[index]
                                                      .helpType))));
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
                                    // Text(helpingList[index].needer.fullName)
                                  ],
                                )),
                          );
                        });
                  }
                },
              ));
  }
}
