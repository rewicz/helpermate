import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/RoitButton.dart';
import 'package:helpermate/components/rating.dart';
import 'package:helpermate/components/textInputBox.dart';
import 'package:helpermate/models/userHelper.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/imageCloudService.dart';

class ProfileHelper extends StatefulWidget {
  String uid;
  String helpUID;
  bool acceptable;

  ProfileHelper({required this.uid,required this.helpUID,required this.acceptable});

  @override
  _ProfileHelperState createState() => _ProfileHelperState();
}

class _ProfileHelperState extends State<ProfileHelper> {
  late UserHelper _helper;
  late String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
  late bool loading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    await ImageCloudService().downoladUserPhotoByUid(widget.uid).then((value) => imageurl = value);
    await FirebaseService().readUserData(widget.uid).then((value) => setState(() {
          _helper = value!;
          loading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: loading
              ? Center(child: CircularProgressIndicator(color: Theme.of(context).accentColor,),)
              : ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Profil pomocnika",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
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
                                    image: NetworkImage(
                                      imageurl,
                                    ))),
                          ),
                        ],
                      ),
                    ),
                    RatingRead(
                        rate: _helper.rate, numberOfrate: _helper.amountOdRates, uid: widget.uid,),
                    SizedBox(
                      height: 35,
                    ),
                    TextInputBox(
                      readonly: true,
                      labelText: _helper.email,
                      icon: Icon(
                        Icons.email,
                      ),
                      text: "Email",
                      callback: (String value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputBox(
                      readonly: true,
                      labelText: _helper.fullName,
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      text: "Imię i nazwisko", callback: (String value) {  },

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextInputBox(
                      readonly: true,
                      labelText: _helper.telephone,
                      icon: Icon(
                        Icons.phone,
                      ),
                      text: "Numer telefonu", callback: (String value) {  },

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextInputBox(
                            readonly: true,
                            labelText:
                                _helper.dateOfBirth.toString().substring(0, 11),
                            icon: Icon(Icons.date_range),
                            callback: (String value) {
                              //chyba nie ma
                            },
                            text: 'Data urodzenia',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextInputBox(
                            readonly: true,
                            labelText: _helper.address,
                            icon: Icon(Icons.home),
                            callback: (String value) {},
                            text: 'Adres zamieszkania',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: widget.acceptable,
                          child: RoitButton(
                              text: "AKCEPTUJ",
                              onPressedCallback: () {
                                FirebaseService().acceptHelpByNeeder(widget.uid,widget.helpUID).then((_) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                              }),
                        ),
                        RoitButton(
                          text: 'WRÓC',
                          onPressedCallback: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

}
