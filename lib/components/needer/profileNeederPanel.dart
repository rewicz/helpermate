import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/firebase/services/authService.dart';
import 'package:helpermate/firebase/services/firebaseService.dart';
import 'package:helpermate/firebase/services/imageCloudService.dart';
import 'package:image_picker/image_picker.dart';

import '../../firebase/services/localizationService.dart';

class ProfileNeederPanel extends StatefulWidget {
  @override
  _ProfileNeederPanelState createState() => _ProfileNeederPanelState();
}

class _ProfileNeederPanelState extends State<ProfileNeederPanel> {
  late Helper _helper;
  late String imageurl =
      'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
  late bool editMode;
  late bool loading = true;

  @override
  void initState() {
    editMode = false;
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    //imageurl = await ImageCloudService().downoladUserPhoto();
    await FirebaseService().readHelperData().then((value) =>
        setState(() {
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
      this.setState(() {
        _image = File(image!.path);
      });
      // usuwam okno dialogowe
    } on PlatformException catch (e) {
      print('Failed to pick image: $e ');
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = File(image!.path);
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
    int endHouseNB;
    String cityDialog = '';
    String streetDialog = '';
    String houseNBDialog = '';
    String apartNBDialog = '';

    if (address.contains('/')) {
      endCity = address.indexOf(' ');
      endStreet = address.indexOf(' ', endCity + 1);
      endHouseNB = address.indexOf('/', endStreet);
      cityDialog = address.substring(0, endCity);
      streetDialog = address.substring(endCity, endStreet);
      houseNBDialog = address.substring(endStreet, endHouseNB);
      apartNBDialog = address.substring(endHouseNB + 1);
    } else {}

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
                    TextInputBox(
                        labelText: apartNBDialog,
                        icon: Icon(Icons.home),
                        callback: (value) {
                          apartNBDialog = value;
                        },
                        text: 'Numer mieszkania (opcjonalnie)'),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoitButton(
                            text: 'ZAPISZ',
                            onPressedCallback: () {
                              this.setState(() {
                                String newAddress =
                                    '$cityDialog $streetDialog $houseNBDialog/$apartNBDialog';
                                _helper.address = newAddress;
                              });
                              Navigator.of(context).pop();
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
            ? CircularProgressIndicator()
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme
                                .of(context)
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
                                color: Theme
                                    .of(context)
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
            Rating(
                rate: _helper.rate, numberOfrate: _helper.amountOdRates),
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
                        text: "Edytuj",
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
                    readonly: !editMode,
                    labelText: _helper.address,
                    icon: Icon(Icons.home),
                    callback: (String value) {},
                    text: 'Adres zamieszkania',
                  ),
                ),
                Visibility(
                    visible: editMode,
                    child: RoitButton(
                        text: "Edytuj",
                        onPressedCallback: () {
                          showChoiceDialog(context);
                        })),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 35,
            ),
            Visibility(
              visible: !editMode,
              child: RoitButton(
                text: 'EDYTUJ',
                onPressedCallback: () {
                  setState(() {
                    editMode = true;
                  });
                },
              ),
            ),
            Visibility(
                visible: editMode,
                child: RoitButton(
                    text: "Zmień hasło",
                    onPressedCallback: () {
                      AuthService().resetPassword();
                    })),
            SizedBox(
              height: 10,
            ),
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
            )
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
    if (_helper.dateOfBirth.year == DateTime
        .now()
        .year) {
      errors.add('Wypełnij date urodzenia!');
    }
    if (_helper.telephone.isEmpty) {
      errors.add('Wypełnij numer telefonu!');
    }

    if (errors.isNotEmpty) {
      print(errors);
      //todo toast
      return false;
    } else {
      return true;
    }
  }
}
