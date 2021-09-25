import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';

class ProfilePanel extends StatefulWidget {
  @override
  _ProfilePanelState createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  String userName = "Adam";
  int rate = 5;
  int numberOfrate = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleBox(title: userName),
            ClipOval(child:
            new Container(
              width: 150.0,
              height: 150.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            ),
            Rating(
              rate: rate, numberOfrate: 26,
            )
          ],
        ),
      );
  }
}
