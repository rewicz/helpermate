import 'package:flutter/material.dart';

class RoitButton extends StatelessWidget {
  final String text;
  VoidCallback? onPressedCallback;

  RoitButton({required this.text, required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Theme.of(context).buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ))),
        onPressed: onPressedCallback,
        child: Text(
          text,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}

class RoitBigButton extends StatelessWidget {
  final String text;
  VoidCallback? onPressedCallback;

  RoitBigButton({required this.text, required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).buttonColor,
          ),
          onPressed: onPressedCallback,
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}