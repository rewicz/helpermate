import 'package:flutter/material.dart';
import 'package:helpermate/pages/login.dart';
import 'package:helpermate/pages/chosenPanel.dart';
import 'package:helpermate/pages/helperPanel.dart';
import 'package:helpermate/pages/neederPanel.dart';

void main() => runApp(MaterialApp(
  title: 'HelepMate',
  theme: ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.blueAccent,
  ),
  initialRoute: '/',
    routes: {
      '/' : (context) => Login(),
      '/chosen' : (context) => ChosenPanel(),
      '/helper' : (context) => HelperPanel(),
      '/needer' : (context) => NeederPanel(),
    },
));