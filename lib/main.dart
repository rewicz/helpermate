import 'package:flutter/material.dart';
import 'package:helpermate/pages/login.dart';
import 'package:helpermate/pages/chosenPanel.dart';
import 'package:helpermate/pages/helperPanel.dart';
import 'package:helpermate/pages/neederPanel.dart';
import 'package:helpermate/pages/signUp.dart';

void main() => runApp(MaterialApp(
  title: 'HelepMate',
  theme: ThemeData(
    primaryColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.blueAccent,
  ),
  initialRoute: '/',
    routes: {
      '/' : (context) => Login(),
      '/signUp' : (context) => SignUp(),
      '/chosen' : (context) => ChosenPanel(),
      '/helper' : (context) => HelperPanel(),
      '/needer' : (context) => NeederPanel(),
    },
));