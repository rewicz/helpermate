import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helpermate/data/helpingPlanHelperData.dart';

class HelpingPlanNeederPanel extends StatefulWidget {

  int id;
  HelpingPlanNeederPanel({required this.id});

  @override
  _HelpingPlanNeederPanelState createState() => _HelpingPlanNeederPanelState(id: id);
}

class _HelpingPlanNeederPanelState extends State<HelpingPlanNeederPanel> {
  int id;

  _HelpingPlanNeederPanelState({required this.id});

  List<HelpObject> helpingList = <HelpObject> [
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            itemCount: helpingList.length,
            itemBuilder: (context, index){
              return Card(
                child: ListTile(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Rate'),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                  title: Text("as"),

                ),

              );
            }
        )
    );
  }
}
