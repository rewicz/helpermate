import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';

class ProfileHelperPanel extends StatefulWidget {
  @override
  _ProfileHelperPanelState createState() => _ProfileHelperPanelState();
}

class _ProfileHelperPanelState extends State<ProfileHelperPanel> {
  late String userName;
  late String helpArea;
  late String city; //todo do poprawy
  late String street;
  late String houseNB;
  late String apartNB;
  late String province;
  late double rate ;
  late int numberOfrate;
  late bool editMode;
  late String dateOfBirth;

  @override
  void initState() {
    userName = "Adam";
    rate = 5;
    numberOfrate = 20;
    editMode = false;
    dateOfBirth = "2001-11-22";
    city='Gliwice';
    street='Paderewskiego';
    houseNB='10';
    apartNB='1';
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(int.parse(dateOfBirth.substring(0, 4))),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (pickedDate != null)
      setState(() {
        dateOfBirth = pickedDate.toString().substring(0, 11);
      });
  }

  Future<void> showChoiceDialog(BuildContext context) {
    String cityDialog = city;
    String streetDialog = street;
    String houseNBDialog = houseNB;
    String apartNBDialog = apartNB;

    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Wpisz adres'),
        content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextInputBox(
                    icon: Icon(Icons.home),
                    callback: (value) {cityDialog = value;},
                    text: 'Miejscowość'),
                TextInputBox(
                    icon: Icon(Icons.home),
                    callback: (value) {streetDialog = value;},
                    text: 'Ulica'),
                TextInputBox(
                    icon: Icon(Icons.home),
                    callback: (value) {houseNBDialog = value;},
                    text: 'Numer domu'),
                TextInputBox(
                    icon: Icon(Icons.home),
                    callback: (value) {apartNBDialog = value;},
                    text: 'Numer mieszkania (opcjonalnie)'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoitButton(text: 'SAVE',
                        onPressedCallback: () {
                          this.setState(() {
                            city = cityDialog;
                            street = streetDialog;
                            houseNB = houseNBDialog;
                            apartNB = apartNBDialog;
                          });
                          Navigator.of(context).pop();
                        }),
                    RoitButton(text: 'CANCEL', onPressedCallback: () {
                      Navigator.of(context).pop();
                    }),
                  ],
                )

              ],
            )

        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            Text(
              editMode?"Edycja profilu":"Profil",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ))),
                  ),
                  Visibility(
                    visible: editMode,
                    child: Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
            Rating(rate: rate, numberOfrate: numberOfrate),
            SizedBox(
              height: 35,
            ),
            TextInputBox(
              readonly: !editMode,
              labelText: "Adam Madej",
              icon: Icon(
                Icons.person,
              ),
              text: "Imię i nazwisko",
              callback: (String value) {  },
            ),
            TextInputBox(
              readonly: !editMode,
              labelText: "email@email.pl",
              icon: Icon(
                Icons.email,
              ),
              text: "Email",
              callback: (String value) {  },
            ),
            TextInputBox(
              readonly: !editMode,
              labelText: "50123123123",
              icon: Icon(
                Icons.phone,
              ),
              text: "Numer telefonu",
              callback: (String value) {  },
            ),
            PasswordLabelBox(
              readonly: !editMode,
              labelText: "1234",
              text: "Hasło",
            ),
            Row(
              children: [
                Expanded(
                  child: TextInputBox(
                    readonly: !editMode,
                    labelText: dateOfBirth,
                    icon: Icon(Icons.date_range),
                    callback: (String value) { dateOfBirth = value; },
                    text: 'Data urodzenia',
                  ),
                ),
                Visibility(
                    visible: editMode,
                    child: RoitButton(text: "Edytuj", onPressedCallback: () {_selectDate(context);})
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextInputBox(
                    readonly: !editMode,
                    labelText: '$city $street $houseNB/$apartNB',
                    icon: Icon(Icons.home),
                    callback: (String value) {  },
                    text: 'Adres zamieszkania',
                  ),
                ),
                Visibility(
                  visible: editMode,
                    child: RoitButton(text: "Edytuj", onPressedCallback: () {
                      showChoiceDialog(context);
                    })
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Visibility(
              visible: !editMode,
              child: RoitButton(
                text: 'Edit',
                onPressedCallback: () {
                  setState(() {
                    editMode = true;
                  });
                },
              ),
            ),
            Visibility(
              visible: editMode,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoitButton(text: 'SAVE',
                      onPressedCallback: () {
                    setState(() {
                      editMode = false;
                    });
                  }),
                  RoitButton(text: 'CANCEL', onPressedCallback: () {
                    setState(() {
                      editMode = false;
                    });
                  }),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
