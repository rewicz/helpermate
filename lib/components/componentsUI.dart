import 'package:flutter/material.dart';

class TitleBox extends StatelessWidget {
  final String title;

  TitleBox({
      required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sign In',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextInputBox extends StatelessWidget {

  final ValueSetter<String> callback;
  final String text;
  final Icon icon;
  final String hint;
  final TextInputType keyboardType ;
  String? Function(String?)? validatorMethod;
  GestureTapCallback? onTap;

  TextInputBox({
    this.onTap,
    this.validatorMethod,
    this.keyboardType : TextInputType.text,
    required this.hint,
    required this.icon,
    required this.callback,
    required this.text
    }
  );

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
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: onTap,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              focusColor: Colors.amberAccent,
              prefixIcon: icon,
              hintText: hint,
            ),

            validator: validatorMethod,
            onChanged: callback,
          ),
        ],
      ),
    );
  }
}

class DataPickerBox extends StatefulWidget {
  final String text;
  ValueSetter<DateTime> callback;

  DataPickerBox({
    required this.text,
    required this.callback,
  });

  @override
  _DataPickerBoxState createState() => _DataPickerBoxState(text: text, callback: callback);
}

class _DataPickerBoxState extends State<DataPickerBox> {

  DateTime currentDate = DateTime.now();
  String text;
  ValueSetter<DateTime> callback;
  bool wybranaData = false;
  final TextEditingController _textController = new TextEditingController(text: 'RRRR-MM-DD');


  _DataPickerBoxState({
    required this.callback,
    required this.text
  });

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
        callback(currentDate);
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
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextFormField(
            controller: _textController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: () {_selectDate(context);},
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              focusColor: Colors.amberAccent,
              prefixIcon: Icon(
                Icons.date_range,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );;
  }
}

class RoitButton extends StatelessWidget {
  final String text;
  Function onPressedCallback;

  RoitButton({
    required this.text,
    required this.onPressedCallback
  });


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: FlatButton(
        color: Colors.indigo,
        onPressed: onPressedCallback(),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

  }
}
