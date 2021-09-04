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
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 50),

                TitleBox(title: 'Sign in'),

                SizedBox(height: 40),

                TextInputBox(
                  hint: "Enter your email",
                  icon:  Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  text: 'Email',
                  callback: (String value) {email = value;},
                  validatorMethod: (value) {
                    if(value!.isEmpty || value.length > 5) {
                      return 'bad email';
                    } else {
                      return null;
                    }
                }

                ),

                SizedBox(height: 30),

                TextInputBox(
                  hint: "Password",
                  icon:  Icon(
                    Icons.password_rounded,
                    color: Colors.white,
                  ),
                  text: 'Enter your password',
                  callback: (String value) {password = value;},
                   // ignore: non_constant_identifier_names
                  validatorMethod: (value) {
                    if(value!.isEmpty || value.length > 5) {
                      return 'bad email';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 50),

                Center(
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FlatButton(
                        color: Colors.indigo,
                        onPressed: () => {submitPassword()},
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
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
                      ],
                      ),
                  ),
                ),
              ],
            ),
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
