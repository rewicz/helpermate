import 'package:flutter/material.dart';


class TextInputBox extends StatelessWidget {
  final ValueSetter<String> callback;
  final String text;
  final Icon icon;
  final String hint;
  final String labelText;
  final bool readonly;
  final TextInputType keyboardType;

  final controllerName = TextEditingController();

  final String? Function(String?)? validatorMethod;
  final GestureTapCallback? onTap;

  TextInputBox(
      {this.labelText: "",
        this.readonly: false,
        this.onTap,
        this.validatorMethod,
        this.keyboardType: TextInputType.text,
        this.hint: "",
        required this.icon,
        required this.callback,
        required this.text}) {
    controllerName.text = labelText;
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
            controller: controllerName,
            readOnly: readonly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onTap: onTap,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
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
