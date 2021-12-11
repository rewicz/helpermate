import 'package:flutter/material.dart';

class TitleBox extends StatelessWidget {
  final String title;

  TitleBox({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
