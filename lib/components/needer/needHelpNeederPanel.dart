import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/pages/createHelp.dart';

class NeedHelpNeederPanel extends StatefulWidget {
  @override
  _NeedHelpNeederPanelState createState() => _NeedHelpNeederPanelState();
}

class _NeedHelpNeederPanelState extends State<NeedHelpNeederPanel> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoitButton(
        onPressedCallback: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateHelp()));
        },
        text: 'Dodaj pomoc',
      ),
    );
  }
}
