import 'package:flutter/material.dart';
import 'package:helpermate/pages/home.dart';
import 'package:helpermate/pages/login.dart';
import 'package:helpermate/pages/chosenPanel.dart';
import 'package:helpermate/pages/helperPanel.dart';
import 'package:helpermate/pages/neederPanel.dart';
import 'package:helpermate/pages/signUp.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:helpermate/styles/theme.dart';


void main() async {
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String title = 'EDT - Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelepMate',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/signUp': (context) => SignUp(),
        '/chosen': (context) => ChosenPanel(),
        '/helper': (context) => HelperPanel(),
        '/needer': (context) => NeederPanel(),
      },
    );
  }
}