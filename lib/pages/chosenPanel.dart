import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/RoitButton.dart';
import 'package:helpermate/pages/helperPanel.dart';
import 'package:helpermate/pages/neederPanel.dart';

class ChosenPanel extends StatefulWidget {
  final Function onSignOut;

  ChosenPanel({required this.onSignOut});

  @override
  _ChosenPanelState createState() => _ChosenPanelState();
}

class _ChosenPanelState extends State<ChosenPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [EasyDynamicThemeSwitch()
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RoitBigButton(
              text: 'Wolontariusz',
              onPressedCallback: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => HelperPanel(onSignOut: widget.onSignOut)))
              },
            ),
            RoitBigButton(
              text: 'Potrzebujący pomocy',
              onPressedCallback: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NeederPanel(onSignOut: widget.onSignOut)))
              },
            ),
          ],
        ),
      ),
    );
  }
}
