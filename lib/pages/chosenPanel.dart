import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/data/sessionData.dart';

class ChosenPanel extends StatefulWidget {
  @override
  _ChosenPanelState createState() => _ChosenPanelState();
}

class _ChosenPanelState extends State<ChosenPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        actions: [EasyDynamicThemeAutoSwitch()],
    ),
    body: Container(
      color: Theme.of(context).backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).buttonColor,
                ),
                onPressed: () => {
                  Navigator.pushNamed(context, '/helper')
                },
                child: Text(
                  "I am Helper",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
          Container(
            width: 400.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).buttonColor,
                ),
                onPressed: () => {
                  Navigator.pushNamed(context, '/needer')
                },
                child: Text(
                  "I am helping",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
