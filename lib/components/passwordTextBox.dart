import 'package:flutter/material.dart';

class PasswordLabelBox extends StatefulWidget {
  final String text;
  final String labelText;
  final bool readonly;
  final ValueSetter<String> callback;

  PasswordLabelBox({
    required this.text,
    required this.labelText,
    required this.readonly,
    required this.callback,
  });

  @override
  _PasswordLabelBoxState createState() => _PasswordLabelBoxState(
      text: text, labelText: labelText, readonly: readonly);
}

class _PasswordLabelBoxState extends State<PasswordLabelBox> {
  final String text;
  final String labelText;
  final bool readonly;

  bool showPassword = false;

  _PasswordLabelBoxState(
      {required this.readonly, required this.labelText, required this.text});

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
            onChanged: widget.callback,
            initialValue: labelText,
            obscureText: !showPassword,
            obscuringCharacter: "*",
            readOnly: readonly,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                prefixIcon: Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                ),
                hintText: 'Wpisz hasło'),
          ),
        ],
      ),
    );
  }
}
