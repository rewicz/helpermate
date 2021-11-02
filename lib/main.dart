import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:helpermate/styles/theme.dart';

import 'decisionTree.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HeleperMate',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: contrastThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: DecisionTree(),
    );
  }
}

