import 'package:flutter/material.dart';

var lightThemeData = new ThemeData(
    backgroundColor: Color(0xff15C7F4),
    buttonColor: Colors.indigoAccent,
    primaryColor: Colors.blue,
    //textTheme: new TextTheme(button: TextStyle(color: Colors.white70)),
    brightness: Brightness.light,
    accentColor: Colors.white);

var contrastThemeData = ThemeData(
    backgroundColor: Colors.black,
    buttonColor: Colors.yellow, //działa
    primaryColor: Colors.black, // appbar
    toggleableActiveColor: Colors.yellow, //switch
    brightness: Brightness.dark,
    accentColor: Colors.black,

);
