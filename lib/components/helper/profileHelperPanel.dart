import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:helpermate/components/componentsUI.dart';

class ProfileHelperPanel extends StatefulWidget {
  @override
  _ProfileHelperPanelState createState() => _ProfileHelperPanelState();
}

class _ProfileHelperPanelState extends State<ProfileHelperPanel> {
  late String userName;
  late String helpArea;
  late String city;
  late String province;
  late double rate ;
  late int numberOfrate;
  late bool editMode;
  late DateTime dateOdBirth;


  @override
  void setState(VoidCallback fn) {
    print(editMode);
    super.setState(fn);
  }

  @override
  void initState() {
    userName = "Adam";
    rate = 5;
    numberOfrate = 20;
    editMode = false;
    super.initState();
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
              "Edit Profile",
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
              text: "Full name",
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
            PasswordLabelBox(
                readonly: !editMode,
                labelText: "1234",
                text: "Password",
            ),
            DataPickerBox(
              text: 'Date of birth',
              callback: (DateTime value) {
                dateOdBirth = value;
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropDownBox(
                  items: ['Gliwice','Zabrze','Gdansk'],
                  initValue: 'Gliwice',
                  callback: (String value) {
                    city = value;
                  },
                ),
                DropDownBox(
                  items: ['Slask','Pomorze','Lubuskie'],
                  initValue: 'Slask',
                  callback: (String value) {
                    province = value;
                  },
                )]
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
