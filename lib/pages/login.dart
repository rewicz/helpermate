import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              buildEmail(),
              SizedBox(height: 30),
              buildPassword(),
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
                onTap: () => {print("SIGN UP")},
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
    );
  }

 Widget buildEmail() => Container(
   width: 350.0,
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Text(
         'Email',
         style: TextStyle(
           color: Colors.white,
           fontSize: 20.0,
           fontWeight: FontWeight.normal,
         ),
       ),
       TextField(
         keyboardType: TextInputType.emailAddress,
         decoration: InputDecoration(
           focusedBorder: UnderlineInputBorder(
               borderSide: BorderSide(color: Colors.white)
           ),
           focusColor: Colors.amberAccent,
           prefixIcon: Icon(
             Icons.email,
             color: Colors.white,
           ),
           hintText: 'Enter your email',
         ),
         onChanged: (value) => setState(() => email = value),
       ),
     ],
   ),
 );

  buildPassword() =>  Container(
    width: 350.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusColor: Colors.amberAccent,
              prefixIcon: Icon(
                Icons.password_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
            ),
            onChanged: (value) => setState(() => password = value),
          ),
      ],
    ),
  );

  void submitPassword() {
    print("$email, $password ");
    Navigator.pushNamed(context, '/chosen');
  }

}
