import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';
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
                onPressedCallback: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
