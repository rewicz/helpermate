import 'package:flutter/material.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('asdas'),
        actions: [EasyDynamicThemeSwitch()],
      ),
      body: Text('ss')

    );
  }
}
