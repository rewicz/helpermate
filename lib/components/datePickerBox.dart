import 'package:flutter/material.dart';

class DataPickerBox extends StatefulWidget {
  final String text;
  ValueSetter<DateTime> callback;

  DataPickerBox({
    required this.text,
    required this.callback,
  });

  @override
  _DataPickerBoxState createState() =>
      _DataPickerBoxState(text: text, callback: callback);
}

class _DataPickerBoxState extends State<DataPickerBox> {
  DateTime currentDate = DateTime.now();
  String text;
  ValueSetter<DateTime> callback;
  bool wybranaData = false;
  final TextEditingController _textController =
  new TextEditingController(text: 'RRRR-MM-DD');

  _DataPickerBoxState({required this.callback, required this.text});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        wybranaData = true;
        _textController.text = pickedDate.toString().substring(0, 11);
        callback(pickedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextFormField(
            controller: _textController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: () {
              _selectDate(context);
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusColor: Colors.amberAccent,
              prefixIcon: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}