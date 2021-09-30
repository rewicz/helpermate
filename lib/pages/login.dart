import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';

class Login extends StatefulWidget {

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
              TitleBox(title: 'Sign in'),
              TextInputBox(
                hint: "Enter your email",
                icon:  Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                text: 'Email',
                callback: (String value) {email = value;},
                validatorMethod: (value) {
                  //nothing
                }
              ),
              TextInputBox(
                hint: "Password",
                icon:  Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: 'Enter your password',
                callback: (String value) {password = value;},
                 // ignore: non_constant_identifier_names
                validatorMethod: (value) {
                  if(value != null) {
                    //nothing
                  }
                },
              ),
              Container(
                width: 100.0,
                height: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () => {submitPassword()},
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/signUp')},
                child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Dont have account?  ',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                        ),
                        TextSpan(
                            text: 'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                        ),
                    ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitPassword() {
    final isValid = formKey.currentState!.validate();
    print("$email, $password");
    if(isValid) {
      Navigator.pushNamed(context, '/chosen');
    }
  }

}