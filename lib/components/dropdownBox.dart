import 'package:flutter/material.dart';


class DropDownBox extends StatefulWidget {
  String initValue;
  List<String> items;
  ValueSetter<String> callback;

  DropDownBox(
      {required this.items, required this.callback, required this.initValue});

  @override
  State<DropDownBox> createState() =>
      _DropDownBoxState(items: items, initValue: initValue, callback: callback);
}

class _DropDownBoxState extends State<DropDownBox> {
  List<String> items;
  String initValue;
  ValueSetter<String> callback;

  _DropDownBoxState(
      {required this.items, required this.callback, required this.initValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 26,
      style: const TextStyle(
        color: Colors.deepPurple,
        fontSize: 20.0,
      ),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          initValue = newValue!;
          callback(newValue);
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}