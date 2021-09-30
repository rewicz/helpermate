import 'package:flutter/material.dart';


class NeedHelpNeederPanel extends StatefulWidget {
  @override
  _NeedHelpNeederPanelState createState() => _NeedHelpNeederPanelState();
}

class _NeedHelpNeederPanelState extends State<NeedHelpNeederPanel> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {  },
        child: Text('Need help'),
      ),
    );
  }
}
