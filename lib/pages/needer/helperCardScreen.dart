import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpermate/components/roitButton.dart';
import 'package:helpermate/components/rating.dart';
import 'package:helpermate/components/textInputBox.dart';
import 'package:helpermate/pages/needer/profileHelper.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/models/helperToAccept.dart';
import 'package:helpermate/models/userHelper.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/imageCloudService.dart';

class HelperCardScreen extends StatefulWidget {
  HelpObjectOutputHelper helpObject;

  bool vote = false;
  bool isEnd = false;
  bool isAccept = true;

  HelperCardScreen({required this.helpObject});

  @override
  _HelperCardScreenState createState() => _HelperCardScreenState();
}

class _HelperCardScreenState extends State<HelperCardScreen> {
  List<HelpState> statesWithHelper = [
    HelpState.RATING,
    HelpState.RATINGHELPER,
    HelpState.RATINGNEEDER,
    HelpState.GOOD
  ];
  bool loading = true;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
  late UserHelper helper;
  bool gotHelper = false;

  @override
  void initState() {
    super.initState();
    _getHelper();
  }

  _getHelper() async {
    if (statesWithHelper
        .any((element) => widget.helpObject.helpState.name == element.name)) {
      await ImageCloudService()
          .downoladUserPhotoByUid(widget.helpObject.helpers!.first)
          .then((value) => imageUrl = value);
      FirebaseService()
          .readUserData(widget.helpObject.helpers!.first)
          .then((value) => setState(() {
                helper = value!;
                loading = false;
                gotHelper = true;
              }));
    } else {
      helper = UserHelper(
          fullName: 'fullName',
          rate: 2,
          amountOdRates: 2,
          email: 'a',
          telephone: '2',
          dateOfBirth: DateTime.now(),
          localization: GeoPoint(1, 1),
          address: 'address');
      loading = false;
    }
  }

  Future<void> showChoiceDialog(
      BuildContext context, List<HelperToAccept> helpers) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Wybierz pomocnika'),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                    itemCount: helpers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => ProfileHelper(
                                        uid: helpers[index].uid,
                                        helpUID: widget.helpObject.id,
                                        acceptable: true,
                                      )))
                              .then((value) => setState(() {
                                    _getHelper();
                                  }));
                        },
                        title: Text(helpers[index].fullname),
                      );
                    }),
              ));
        });
  }

  Future<void> showChoiceDialogRate(BuildContext context) {
    String message = '';
    double rate = 0;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Ocena pomocnika'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Rating(
                      callback: (double value) {
                        rate = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInputBox(
                        icon: Icon(Icons.comment),
                        callback: (value) {
                          message = value;
                        },
                        text: 'Dodatkowy komentarz'),
                    SizedBox(
                      height: 20,
                    ),
                    RoitButton(
                        text: 'OCEŃ',
                        onPressedCallback: () {
                          List<String> errors = [];
                          if (rate == 0) {
                            errors.add('Dodaj ocene');
                          }
                          if (errors.isNotEmpty) {
                            Fluttertoast.showToast(
                                msg: errors.toString(),
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            _sendRate(rate, message);
                          }
                        })
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text('Karta pomocy')),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Data pomocy:   ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.helpObject.helpingTime
                              .toString()
                              .substring(0, 11),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Godzina:   ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.helpObject.helpingHour,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rodzaj:   ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.helpObject.helpType.getDescribe,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: widget.helpObject.message.isNotEmpty,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dodatkowa wiadomość:   ',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            widget.helpObject.message,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: gotHelper,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageUrl))),
                    ),
                  ),
                  Visibility(
                    visible: gotHelper,
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  Visibility(
                    visible: gotHelper,
                    child: Center(
                      child: Text(
                        helper.fullName,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: gotHelper,
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  Visibility(
                    visible:
                        widget.helpObject.helpState == HelpState.ACCEPTABLE,
                    child: RoitButton(
                        text: 'WYBIERZ POMOCNIKA',
                        onPressedCallback: () => choseHelper()),
                  ),
                  Visibility(
                    visible: widget.helpObject.helpState == HelpState.GOOD,
                    child: RoitButton(
                        text: 'ZOBACZ POMOCNIKA',
                        onPressedCallback: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ProfileHelper(
                                      uid: widget.helpObject.helpers!.first,
                                      helpUID: widget.helpObject.id,
                                      acceptable: false,
                                    )))),
                  ),
                  Visibility(
                    visible: widget.helpObject.helpState == HelpState.GOOD,
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: widget.helpObject.helpState == HelpState.GOOD,
                    child: RoitButton(
                        text: 'POMOC SIĘ ZAKOŃCZYŁA',
                        onPressedCallback: () => finishHelp()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: !(widget.helpObject.helpState == HelpState.RATING || widget.helpObject.helpState == HelpState.RATINGHELPER || widget.helpObject.helpState == HelpState.RATINGNEEDER || widget.helpObject.helpState == HelpState.ARCHIVE),
                    child: RoitButton(
                        text: 'USUŃ POMOC',
                        onPressedCallback: () => deleteHelp()),
                  ),
                ],
              ),
            ),
      floatingActionButton: Visibility(
        visible: widget.helpObject.helpState == HelpState.RATING ||
            widget.helpObject.helpState == HelpState.RATINGNEEDER,
        child: FloatingActionButton.extended(
          onPressed: () {
            showChoiceDialogRate(context).then((value) => setState(() {
                  _getHelper();
                }));
          },
          label: Text("Dodaj ocene"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  deleteHelp() {
    FirebaseService().deleteHelp(widget.helpObject.id);
    Navigator.of(context).pop();
  }

  _sendRate(double rate, String message) {
    FirebaseService()
        .sendHelperRate(rate, message, widget.helpObject)
        .then((value) => () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
  }

  finishHelp() {
    FirebaseService()
        .finishHelp(widget.helpObject)
        .then((value) => Navigator.pop(context));
  }

  choseHelper() {
    FirebaseService()
        .getHelpersToAccept(widget.helpObject.helpers)
        .then((value) => showChoiceDialog(context, value!))
        .then((value) {
      loading = true;
      setState(() {
        _getHelper();
      });
    });
  }
}
