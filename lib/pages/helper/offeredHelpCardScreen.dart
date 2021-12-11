import 'package:flutter/material.dart';
import 'package:helpermate/components/roitButton.dart';
import 'package:helpermate/components/rating.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/userHelper.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/imageCloudService.dart';

class OfferedHelpCardScreen extends StatefulWidget {
  OfferedHelpCardScreen({required this.helpObject});

  HelpObjectOutputHelper helpObject;

  @override
  _OfferedHelpCardScreenState createState() => _OfferedHelpCardScreenState();
}

class _OfferedHelpCardScreenState extends State<OfferedHelpCardScreen> {
  late UserHelper needer;
  bool loading = true;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';

  @override
  void initState() {
    super.initState();
    _getNeeder();
  }

  _getNeeder() async {
    await ImageCloudService().downoladUserPhotoByUid(widget.helpObject.needer).then((value) => imageUrl = value);

    FirebaseService()
        .readUserData(widget.helpObject.needer)
        .then((value) => setState(() {
              needer = value!;
              loading = false;
            }));
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
                  Container(
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
                            fit: BoxFit.cover, image: NetworkImage(imageUrl))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      needer.fullName,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RatingRead(rate: needer.rate, numberOfrate: needer.amountOdRates, uid: widget.helpObject.needer,),
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
                          'Odległość:   ',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.helpObject.distance.toStringAsFixed(2) +
                              ' (km)',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoitButton(
                          text: 'AKCEPTUJ',
                          onPressedCallback: () => acceptHelp()),
                      RoitButton(
                          text: 'ANULUJ',
                          onPressedCallback: () => Navigator.of(context).pop())
                    ],
                  )
                ],
              ),
            ),
    );
  }

  acceptHelp() async {
    await FirebaseService().acceptHelpByHelper(widget.helpObject);
    Navigator.of(context).pop();
  }
}
