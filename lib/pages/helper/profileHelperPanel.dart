import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpermate/components/roitButton.dart';
import 'package:helpermate/components/rating.dart';
import 'package:helpermate/components/textInputBox.dart';
import 'package:helpermate/models/helper.dart';
import 'package:helpermate/services/authService.dart';
import 'package:helpermate/services/firebaseService.dart';
import 'package:helpermate/services/imageCloudService.dart';
import 'package:helpermate/services/localizationService.dart';
import 'package:helpermate/services/userSecureStorage.dart';
import 'package:image_picker/image_picker.dart';


class ProfileHelperPanel extends StatefulWidget {
  @override
  _ProfileHelperPanelState createState() => _ProfileHelperPanelState();
}

class _ProfileHelperPanelState extends State<ProfileHelperPanel> {
  late Helper _helper;
  late String uid;
  late String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
  late bool editMode;
  late bool loading = true;
  late bool hasPhoto = false;

  @override
  void initState() {
    editMode = false;
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    await UserSecureStorage.getUID().then((value) => uid = value!);

    await ImageCloudService().downoladUserPhoto().then((value) => imageurl = value);
    await FirebaseService().readHelperData().then((value) => setState(() {
          _helper = value!;
          loading = false;
        }));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _helper.dateOfBirth,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      setState(() {
        _helper.dateOfBirth = pickedDate;
      });
  }

  File? _image;

  _openGalery(BuildContext context) async {
    try {
      //pobieram zdjęcie z galeri
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await ImageCloudService().uploadUserPhoto(File(image!.path));
      this.setState(() {
        _getUserData();
      });
      // usuwam okno dialogowe
    } on PlatformException catch (e) {
      print('Failed to pick image: $e ');
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    await ImageCloudService().uploadUserPhoto(File(image!.path));
    this.setState(() {
      _getUserData();
    });
    // usuwam okno dialogowe
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialogCamera(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wybierz skąd chcesz wybrać zdjęcie'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                GestureDetector(
                  child: Text('Galeria'),
                  onTap: () {
                    _openGalery(context);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: Text('Kamera'),
                  onTap: () {
                    _openCamera(context);
                  },
                ),
              ],
            )),
          );
        });
  }

  Future<void> showChoiceDialog(BuildContext context) {
    String address = _helper.address;
    int endCity;
    int endStreet;
    String cityDialog = '';
    String streetDialog = '';
    String houseNBDialog = '';

    if (address.isNotEmpty) {
      endCity = address.indexOf(' ');
      endStreet = address.indexOf(' ', endCity + 2);
      cityDialog = address.substring(0, endCity).trim();
      streetDialog = address.substring(endCity, endStreet).trim();
      houseNBDialog = address.substring(endStreet).trim();
    }

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Wpisz adres'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                TextInputBox(
                    labelText: cityDialog,
                    icon: Icon(Icons.home),
                    callback: (value) {
                      cityDialog = value;
                    },
                    text: 'Miejscowość'),
                TextInputBox(
                    labelText: streetDialog,
                    icon: Icon(Icons.home),
                    callback: (value) {
                      streetDialog = value;
                    },
                    text: 'Ulica'),
                TextInputBox(
                    labelText: houseNBDialog,
                    icon: Icon(Icons.home),
                    callback: (value) {
                      houseNBDialog = value;
                    },
                    text: 'Numer domu'),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoitButton(
                        text: 'ZAPISZ',
                        onPressedCallback: () {
                          List<String> errors = [];
                          if (cityDialog.isEmpty) {
                            errors.add('Wpisz nazwę miejscowości!');
                          }
                          if (streetDialog.isEmpty) {
                            errors.add('Wpisz nazwę ulicy!');
                          }
                          if (houseNBDialog.isEmpty) {
                            errors.add('Wpisz numer domu!');
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
                            this.setState(() {
                              String newAddress =
                                  '$cityDialog $streetDialog $houseNBDialog';
                              _helper.address = newAddress;
                              Navigator.of(context).pop();
                            });
                          }
                        }),
                    RoitButton(
                        text: 'ANULUJ',
                        onPressedCallback: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    editMode ? "Edycja profilu" : "Profil",
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
                        Visibility(
                          visible: editMode,
                          child: Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => {showChoiceDialogCamera(context)},
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  RatingRead(
                      rate: _helper.rate, numberOfrate: _helper.amountOdRates, uid: uid,),
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
                    readonly: !editMode,
                    labelText: _helper.fullName,
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    text: "Imię i nazwisko",
                    callback: (String value) {
                      _helper.fullName = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextInputBox(
                    keyboardType: TextInputType.phone,
                    readonly: !editMode,
                    labelText: _helper.telephone,
                    icon: Icon(
                      Icons.phone,
                    ),
                    text: "Numer telefonu",
                    callback: (String value) {
                      _helper.telephone = value;
                    },
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
                      Visibility(
                          visible: editMode,
                          child: RoitButton(
                              text: "EDYTUJ",
                              onPressedCallback: () {
                                _selectDate(context);
                              })),
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
                      Visibility(
                          visible: editMode,
                          child: RoitButton(
                              text: "EDYTUJ",
                              onPressedCallback: () {
                                showChoiceDialog(context);
                              })),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _helper.localization.latitude != 0 &&
                                _helper.localization.longitude != 0
                            ? Text('Lokalizacja jest pobrana')
                            : Text('Zaaktualizuj lokalizacje'),
                      ),
                      Visibility(
                        visible: editMode,
                        child: RoitButton(
                          text: 'POBIERZ',
                          onPressedCallback: () async {
                            await LocalizationService()
                                .getCurrentPosition()
                                .then((value) {
                              setState(() {
                                if (value != null) {
                                  _helper.localization = value;
                                }
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                      visible: !editMode,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            child: RoitButton(
                                text: "RESETUJ HASŁO",
                                onPressedCallback: () {
                                  AuthService().resetPassword().then((value) =>
                                      Fluttertoast.showToast(
                                          msg: 'Wiadomość została wysłana na podany email',
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0));
                                }),
                          ),
                          RoitButton(
                            text: 'EDYTUJ',
                            onPressedCallback: () {
                              setState(() {
                                editMode = true;
                              });
                            },
                          )
                        ],
                      )),
                  Visibility(
                    visible: editMode,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoitButton(
                            text: 'ZAPISZ',
                            onPressedCallback: () {
                              setState(() {
                                if (checkHelpersData()) {
                                  FirebaseService().saveHelperData(_helper);
                                  ImageCloudService().uploadUserPhoto(_image);
                                  editMode = false;
                                }
                              });
                            }),
                        RoitButton(
                            text: 'ANULUJ',
                            onPressedCallback: () {
                              setState(() {
                                editMode = false;
                              });
                            }),
                      ],

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
      ),
    );
  }

  bool checkHelpersData() {
    List<String> errors = [];
    if (_helper.fullName.isEmpty) {
      errors.add('Wypełnij imię i nazwiko!');
    }
    if (_helper.address.isEmpty) {
      errors.add('Wypełnij adres!');
    }
    if (_helper.dateOfBirth.year == DateTime.now().year) {
      errors.add('Wypełnij date urodzenia!');
    }
    if (_helper.telephone.isEmpty) {
      errors.add('Wypełnij numer telefonu!');
    }
    if (_helper.localization == null) {
      errors.add('Pobierz lokalizacje!');
    }
    if (errors.isNotEmpty) {
      Fluttertoast.showToast(
          msg: errors.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else {
      return true;
    }
  }
}
