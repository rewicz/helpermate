import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/pages/settingsPage.dart';
import 'package:helpermate/services/authService.dart';
import 'package:image_picker/image_picker.dart';

class SignUp2 extends StatefulWidget {
  @override
  _SignUpState2 createState() => _SignUpState2();
}

class _SignUpState2 extends State<SignUp2> {
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

  Future<void> showChoiceDialog(BuildContext context) {
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

  Widget _showImage() {
    if (_image != null) {
      return Image.file(_image!, width: 400, height: 400);
    } else {
      return Text('Wczytaj zdjęcie');
    }
  }

  late String fullName;
  late String email;
  late String password;
  late DateTime dateOdBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: SettingPage(
          onSignOut: () {},
        ),
        appBar: AppBar(
          actions: [
            Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: Icon(Icons.settings)))
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                TitleBox(title: "Rejestracja"),
                SizedBox(height: 20.0),
                TextInputBox(
                    hint: 'Wpisz imię i nazwisko',
                    text: 'Imię i nazwisko',
                    callback: (String value) {
                      fullName = value;
                    },
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    validatorMethod: (value) {
                      RegExp regExp = new RegExp(r'^[a-z A-Z,.\-]+$');
                      if (value!.length == 0) {
                        return 'Proszę wpisać imię i nazwisko';
                      } else if (!regExp.hasMatch(fullName)) {
                        return 'Nie używaj znaków specjalnych';
                      } else if (!value.contains(" ") ||
                          value.indexOf(" ") == value.length - 1) {
                        return 'Imię i nazwisko musi być oddzielone spacją';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(height: 20.0),
                TextInputBox(
                  hint: 'Enter your email',
                  text: 'Email',
                  callback: (String value) {
                    email = value;
                  },
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  validatorMethod: (value) {
                    if (value!.contains(new RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                      return 'Email musi być w formie \'test@test.pl\' ';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0),
                TextInputBox(
                  hint: 'Wpisz hasło',
                  text: 'Hasło',
                  callback: (String value) {
                    password = value;
                  },
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  validatorMethod: (value) {
                    if (value!.contains(new RegExp(r'^[a-z0-9_-]{4,8}$'))) {
                      return null;
                    } else {
                      return "Hasło musi zawierać conajmniej jedną literę oraz cyfrę!";
                    }
                  },
                ),
                SizedBox(height: 20.0),
                DataPickerBox(
                  text: 'Data urodzenia',
                  callback: (DateTime value) {
                    dateOdBirth = value;
                  },
                ),
                SizedBox(height: 20.0),
                _image != null
                    ? ClipOval(
                        child: Image.file(_image!,
                            width: 150, height: 150, fit: BoxFit.cover))
                    : ClipOval(
                        child: new Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                SizedBox(height: 20.0),
                Container(
                  width: 100.0,
                  height: 50.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).buttonColor,
                      ),
                      onPressed: () => {showChoiceDialog(context)},
                      child: Text(
                        "Wybierz zdjęcie",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SignUp extends StatefulWidget {
  final Function(User?) onSignIn;

  SignUp({required this.onSignIn});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  late String password2;
  final formKey = GlobalKey<FormState>();

  Future<void> register() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: SettingPage(
          onSignOut: () {},
        ),
        appBar: AppBar(
          actions: [
            EasyDynamicThemeSwitch(),
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  TitleBox(title: "Rejestracja"),
                  SizedBox(height: 20.0),
                  TextInputBox(
                    hint: 'Enter your email',
                    text: 'Email',
                    callback: (String value) {
                      email = value;
                    },
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    validatorMethod: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email);

                      if (!emailValid) {
                        return 'Email musi być w formie \'test@test.pl\' ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextInputBox(
                    hint: 'Wpisz hasło',
                    text: 'Hasło',
                    callback: (String value) {
                      password = value;
                    },
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    validatorMethod: (value) {
                      if (value!.contains(new RegExp(r'^[a-z0-9_-]{4,8}$'))) {
                        return null;
                      } else {
                        return "Hasło musi zawierać conajmniej jedną literę oraz cyfrę!";
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextInputBox(
                    hint: 'Wpisz hasło',
                    text: 'Powtórz hasło',
                    callback: (String value) {
                      password2 = value;
                    },
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    validatorMethod: (value) {
                      if (password2 != password) {
                        return "Hasła muszą być takie same";
                      } else if (value!
                          .contains(new RegExp(r'^[a-z0-9_-]{4,8}$'))) {
                        return null;
                      } else {
                        return "Hasło musi zawierać conajmniej jedną literę oraz cyfrę!";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RoitButton(
                      text: 'REJESTRUJ',
                      onPressedCallback: () {
                        AuthService()
                            .createUserEmail(email, password)
                            .then((user) {
                          if (user != null) {
                            Navigator.pop(context);
                            widget.onSignIn(user);
                          }
                        });
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
