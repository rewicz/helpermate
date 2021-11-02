import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/data/helpTypes.dart';

class CreateHelp extends StatefulWidget {
  const CreateHelp({Key? key}) : super(key: key);

  @override
  _CreateHelpState createState() => _CreateHelpState();
}

class _CreateHelpState extends State<CreateHelp> {
  String type = '';
  String hour = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          actions: [EasyDynamicThemeSwitch()],
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Text('Wybierz rodzaj pomocy jaką chcesz uzyskać'),
              _createHelpTypers(),
              DataPickerBox(text: 'Podaj date', callback: (value) {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Wybierz godzinę: '),
                  DropDownBox(
                    items: List.generate(24, (index) => '$index:00'),
                    initValue: '10:00',
                    callback: (String value) {
                      hour = value;
                    },
                  ),
                ],
              ),
              TextInputBox(
                  icon: Icon(Icons.comment),
                  callback: (value) {},
                  text: "Dodatkowy komentarz"),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoitButton(text: 'Zapisz', onPressedCallback: () {}),
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
      height: MediaQuery.of(context).size.width,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 30.0,
        mainAxisSpacing: 30.0,
        children: [
          ImageButton(
            path: HelpType.cleaning.getPath,
            checked: type == HelpType.cleaning.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.cleaning.name;
              });
            },
            description: HelpType.cleaning.getDescribe,
          ),
          ImageButton(
            path: HelpType.compan.getPath,
            checked: type == HelpType.compan.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.compan.name;
              });
            },
            description: HelpType.compan.getDescribe,
          ),
          ImageButton(
            path: HelpType.computer.getPath,
            checked: type == HelpType.computer.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.computer.name;
              });
            },
            description: HelpType.computer.getDescribe,
          ),
          ImageButton(
            path: HelpType.grass_cut.getPath,
            checked: type == HelpType.grass_cut.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.grass_cut.name;
              });
            },
            description: HelpType.grass_cut.getDescribe,
          ),
          ImageButton(
            path: HelpType.rubbish.getPath,
            checked: type == HelpType.rubbish.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.rubbish.name;
              });
            },
            description: HelpType.rubbish.getDescribe,
          ),
          ImageButton(
            path: HelpType.shopping.getPath,
            checked: type == HelpType.shopping.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.shopping.name;
              });
            },
            description: HelpType.shopping.getDescribe,
          ),
          ImageButton(
            path: HelpType.walk.getPath,
            checked: type == HelpType.walk.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.walk.name;
              });
            },
            description: HelpType.walk.getDescribe,
          ),
          ImageButton(
            path: HelpType.walk_dog.getPath,
            checked: type == HelpType.walk_dog.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.walk_dog.name;
              });
            },
            description: HelpType.walk_dog.getDescribe,
          ),
          ImageButton(
            path: HelpType.another.getPath,
            checked: type == HelpType.another.name ? true : false,
            onTap: () {
              setState(() {
                type = HelpType.another.name;
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
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Colors.white
                      : Theme.of(context).backgroundColor,
                  border: Border.all(
                      color: widget.checked
                          ? Theme.of(context).buttonColor
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
