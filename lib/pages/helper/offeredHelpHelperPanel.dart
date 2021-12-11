import 'package:flutter/material.dart';
import 'package:helpermate/components/RoitButton.dart';
import 'package:helpermate/components/datePickerBox.dart';
import 'package:helpermate/components/dropdownBox.dart';
import 'package:helpermate/pages/helper/offeredHelpCardScreen.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/firebaseService.dart';


class OfferedHelpHelperPanel extends StatefulWidget {
  @override
  _OfferedHelpHelperPanelState createState() => _OfferedHelpHelperPanelState();
}

class _OfferedHelpHelperPanelState extends State<OfferedHelpHelperPanel> {
  // static Helper me = Helper(
  //     email: 'email@email.com',
  //     address: 'Glwice Soltysowa 10',
  //     fullName: 'Adaam Fertes',
  //     telephone: '123654321',
  //     dateOfBirth: DateTime(2001),
  //     range: 20);
  // static Needer him = Needer(
  //     email: 'email@email.com',
  //     address: 'Glwice Soltysowa 10',
  //     fullName: 'Adaam Fertes',
  //     telephone: '123654321',
  //     dateOfBirth: DateTime(2001));

  @override
  void initState() {
    listHelpTypes.add('Wszystkie');
    filterHelpingTypeNeeder = 'Wszystkie';
    filterDateSecond = null;
    filterDateFirst = null;
    HelpType.values.forEach((element) {
      listHelpTypes.add(element.getDescribe);
    });
    _getHelpingList();

    super.initState();
  }

  _getHelpingList() async {
    await FirebaseService()
        .readAllNotMYHelpObject()
        .then((value) => setState(() {
              helpingList = new List<HelpObjectOutputHelper>.from(value!);
              filterList = new List<HelpObjectOutputHelper>.from(value);
              loading = false;
            }));
  }

  _filter() {
    List<HelpObjectOutputHelper> temp = helpingList;
    List<HelpObjectOutputHelper> result = [];
    bool typeGood, dateFirst, dateSecond;
    temp.forEach((element) {
      if (filterHelpingTypeNeeder != 'Wszystkie') {
        if (element.helpType.getDescribe == filterHelpingTypeNeeder) {
          typeGood = true;
        } else {
          typeGood = false;
        }
      } else {
        typeGood = true;
      }

      if (filterDateFirst != null) {
        if (element.helpingTime.isAfter(filterDateFirst!)) {
          dateFirst = true;
        } else {
          dateFirst = false;
        }
      } else {
        dateFirst = true;
      }

      if (filterDateSecond != null) {
        if (element.helpingTime.isBefore(filterDateSecond!)) {
          dateSecond = true;
        } else {
          dateSecond = false;
        }
      } else {
        dateSecond = true;
      }
      if (typeGood && dateFirst && dateSecond) {
        result.add(element);
      }
      print(result);
      print(element.helpType.getDescribe);
    });
    setState(() {
      filterList = result;
    });
  }

  List<String> listHelpTypes = [];

  bool loading = true;
  List<HelpObjectOutputHelper> helpingList = [];
  List<HelpObjectOutputHelper> filterList = [];

  late String? filterHelpingTypeNeeder;
  late DateTime? filterDateFirst;
  late DateTime? filterDateSecond;

  Future<void> showChoiceDialog(BuildContext context) {
    filterDateFirst = null;
    filterDateSecond = null;
    filterHelpingTypeNeeder = 'Wszystkie';
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
                        items: listHelpTypes,
                        initValue: 'Wszystkie',
                        callback: (String value) {
                          filterHelpingTypeNeeder = value;
                        },
                      ),
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: DataPickerBox(
                            text: 'Od',
                            callback: (value) {
                              filterDateFirst = value;
                            }))
                  ]),
                  Row(children: [
                    Expanded(
                        child: DataPickerBox(
                            text: 'Do',
                            callback: (value) {
                              filterDateSecond = value;
                            }))
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoitButton(
                            text: 'Szukaj',
                            onPressedCallback: () {
                              _filter();
                              Navigator.of(context).pop();
                              setState() {}
                              ;
                            }),
                        RoitButton(
                            text: 'Anuluj',
                            onPressedCallback: () {
                              Navigator.of(context).pop();
                            }),
                      ]),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                  filterDateFirst = null;
                  filterDateSecond = null;
                  filterHelpingTypeNeeder = 'Wszystkie';
                });
              },
              icon: Icon(Icons.clear))
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
          : ListView.builder(
              itemCount: filterList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => OfferedHelpCardScreen(
                                    helpObject: filterList[index])))
                            .then((value) => setState(() {
                                  loading = false;
                                  _getHelpingList();
                                }));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage(filterList[index].helpType.getPath),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(filterList[index]
                              .helpingTime
                              .toString()
                              .substring(0, 11)),
                          Text(filterList[index].distance.toStringAsFixed(2) +
                              ' (km)')
                        ],
                      )),
                );
              }),
    );
  }
}
