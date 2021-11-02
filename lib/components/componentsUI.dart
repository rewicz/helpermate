import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

class TextInputBox extends StatelessWidget {
  final ValueSetter<String> callback;
  final String text;
  final Icon icon;
  final String hint;
  final String labelText;
  final bool readonly;
  final TextInputType keyboardType;

  String? Function(String?)? validatorMethod;
  GestureTapCallback? onTap;

  TextInputBox(
      {this.labelText: "",
      this.readonly: false,
      this.onTap,
      this.validatorMethod,
      this.keyboardType: TextInputType.text,
      this.hint: "",
      required this.icon,
      required this.callback,
      required this.text});

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
            initialValue: labelText,
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
    ;
  }
}

class RoitButton extends StatelessWidget {
  final String text;
  VoidCallback? onPressedCallback;

  RoitButton({required this.text, required this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height / 18,
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

class Rating extends StatelessWidget {
  double rate;
  int numberOfrate;

  Rating({required this.rate, required this.numberOfrate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Rating: ($numberOfrate): ",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        RatingBar.builder(
          initialRating: rate,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ignoreGestures: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (double value) {},
        ),
      ],
    );
  }
}

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
