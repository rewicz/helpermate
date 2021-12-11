import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helpermate/components/RoitButton.dart';
import 'package:helpermate/components/datePickerBox.dart';
import 'package:helpermate/components/dropdownBox.dart';
import 'package:helpermate/components/textInputBox.dart';
import 'package:helpermate/models/helpObjectCreate.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/services/firebaseService.dart';

class CreateHelp extends StatefulWidget {
  const CreateHelp({Key? key}) : super(key: key);

  @override
  _CreateHelpState createState() => _CreateHelpState();
}

class _CreateHelpState extends State<CreateHelp> {

  late HelpObjectCreate helpObjectCreate = new HelpObjectCreate();

  @override
  void initState() {
    helpObjectCreate.helpType = HelpType.rubbish;
    helpObjectCreate.message = '';
    super.initState();
  }

  bool _createHelp() {
    Fluttertoast.showToast(
        msg:
        'Dodano twoją pomoc',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black26,
        textColor: Colors.white,
        fontSize: 16.0);
    FirebaseService().createHelpObject(helpObjectCreate);
    return true;
  }

  bool _checkHelp() {
    List<String> errors = [];
    if(helpObjectCreate.helpingTime.isBefore(DateTime.now()))
        errors.add('Wybierz datę w przyszłości!');
    if (errors.isNotEmpty) {
      Fluttertoast.showToast(
          msg: errors.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        appBar: AppBar(
          actions: [EasyDynamicThemeSwitch()],
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text('Wybierz rodzaj pomocy jaką chcesz uzyskać'),
              _createHelpTypers(),
              DataPickerBox(text: 'Podaj date', callback: (value) {
                helpObjectCreate.helpingTime = value;
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Wybierz godzinę: '),
                  DropDownBox(
                    items: List.generate(24, (index) => '$index:00'),
                    initValue: '10:00',
                    callback: (String value) {
                      helpObjectCreate.helpingHour = value;
                    },
                  ),
                ],
              ),
              TextInputBox(
                labelText: helpObjectCreate.message,
                  icon: Icon(Icons.comment),
                  callback: (value) {
                    helpObjectCreate.message = value;
                  },
                  text: "Dodatkowy komentarz"),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoitButton(text: 'Zapisz', onPressedCallback: () {
                    if (_checkHelp() && _createHelp()) {
                      Navigator.of(context).pop();
                    }
                  }),
                  RoitButton(
                      text: 'Anuluj',
                      onPressedCallback: () {
                          Navigator.of(context).pop();
                      }),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _createHelpTypers() {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery
          .of(context)
          .size
          .width,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 30.0,
        children: [
          ImageButton(
            path: HelpType.cleaning.getPath,
            checked: helpObjectCreate.helpType == HelpType.cleaning
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.cleaning;
              });
            },
            description: HelpType.cleaning.getDescribe,
          ),
          ImageButton(
            path: HelpType.compan.getPath,
            checked: helpObjectCreate.helpType == HelpType.compan
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.compan;
              });
            },
            description: HelpType.compan.getDescribe,
          ),
          ImageButton(
            path: HelpType.computer.getPath,
            checked: helpObjectCreate.helpType == HelpType.computer
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.computer;
              });
            },
            description: HelpType.computer.getDescribe,
          ),
          ImageButton(
            path: HelpType.grass_cut.getPath,
            checked: helpObjectCreate.helpType == HelpType.grass_cut
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.grass_cut;
              });
            },
            description: HelpType.grass_cut.getDescribe,
          ),
          ImageButton(
            path: HelpType.rubbish.getPath,
            checked: helpObjectCreate.helpType == HelpType.rubbish
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.rubbish;
              });
            },
            description: HelpType.rubbish.getDescribe,
          ),
          ImageButton(
            path: HelpType.shopping.getPath,
            checked: helpObjectCreate.helpType == HelpType.shopping
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.shopping;
              });
            },
            description: HelpType.shopping.getDescribe,
          ),
          ImageButton(
            path: HelpType.walk.getPath,
            checked: helpObjectCreate.helpType == HelpType.walk ? true : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.walk;
              });
            },
            description: HelpType.walk.getDescribe,
          ),
          ImageButton(
            path: HelpType.walk_dog.getPath,
            checked: helpObjectCreate.helpType == HelpType.walk_dog
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.walk_dog;
              });
            },
            description: HelpType.walk_dog.getDescribe,
          ),
          ImageButton(
            path: HelpType.another.getPath,
            checked: helpObjectCreate.helpType == HelpType.another
                ? true
                : false,
            onTap: () {
              setState(() {
                helpObjectCreate.helpType = HelpType.another;
              });
            },
            description: HelpType.another.getDescribe,
          ),
        ],
      ),
    );
  }
}

class ImageButton extends StatefulWidget {
  String path;
  String description;
  GestureTapCallback? onTap;
  bool checked;

  ImageButton({
    required this.path,
    required this.description,
    required this.checked,
    required this.onTap,
  });

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .brightness != Brightness.dark
                      ? Colors.white
                      : Theme
                      .of(context)
                      .backgroundColor,
                  border: Border.all(
                      color: widget.checked
                          ? Theme
                          .of(context)
                          .buttonColor
                          : Colors.white,
                      width: 4),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      scale: 1.7, image: AssetImage(widget.path))),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(widget.description),
      ],
    );
  }
}
