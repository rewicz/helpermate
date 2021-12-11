import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpermate/components/RoitButton.dart';
import 'package:helpermate/components/passwordTextBox.dart';
import 'package:helpermate/components/textInputBox.dart';
import 'package:helpermate/components/titleBox.dart';
import 'package:helpermate/pages/signUp.dart';
import 'package:helpermate/services/authService.dart';

class Login extends StatefulWidget {
  final Function(User?) onSignIn;

  Login({required this.onSignIn});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  late String email = "";
  late String password = "";

  Future<void> showChoiceDialog(BuildContext context) {
    String emailReset = '';

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Podaj email na który chcesz zresetować hasło'),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                TextInputBox(
                    icon: Icon(Icons.email),
                    callback: (value) {
                      emailReset = value;
                    },
                    text: 'Email'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoitButton(
                        text: "Zresetuj",
                        onPressedCallback: () {
                          if (emailReset.length > 0) {
                            AuthService().resetPasswordForEmail(emailReset).then(
                                (value) => Fluttertoast.showToast(
                                    msg:
                                        'Wiadomość została wysłana na podany email',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Wpisz email',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }),
                    RoitButton(
                        text: "Anuluj",
                        onPressedCallback: () {
                          Navigator.pop(context);
                        })
                  ],
                ),

              ],
            )),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [EasyDynamicThemeSwitch()],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleBox(title: 'Zaloguj'),
              TextInputBox(
                  hint: "Wpisz email",
                  icon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  text: 'Email',
                  callback: (String value) {
                    email = value;
                  },
                  validatorMethod: (value) {
                    //nothing
                  }),
              PasswordLabelBox(
                text: 'Hasło',
                callback: (String value) {
                  password = value;
                },
                readonly: false,
                labelText: '',
              ),
              RoitButton(
                onPressedCallback: () async {
                  AuthService().signInEmail(email, password).then((value) {
                    widget.onSignIn(value);
                  });
                },
                text: 'ZALOGUJ',
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SignUp(
                            onSignIn: widget.onSignIn,
                          )))
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Nie masz konta?  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Zarejestruj się',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {showChoiceDialog(context)},
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Zapomniałeś hasła?  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'Zresetuj hasło! ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
