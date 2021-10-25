import 'package:flutter/material.dart';
import 'package:helpermate/data/helpObject.dart';

import 'componentsUI.dart';


class HelperCardScreen extends StatefulWidget {
  HelpObject helpObject;
  bool vote = false;
  bool isEnd = false;
  bool isAccept = true;


  HelperCardScreen({required this.helpObject});

  @override
  _HelperCardScreenState createState() => _HelperCardScreenState();
}

class _HelperCardScreenState extends State<HelperCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 4, color: Theme.of(context).scaffoldBackgroundColor),
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
          Center(
            child: Text(
              widget.helpObject.needer.fullName,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          Rating(rate: 1, numberOfrate: 30),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Data pomocy:   ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  widget.helpObject.helpingTime.toString().substring(0, 11),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Adres:   ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  widget.helpObject.needer.address,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rodzaj:   ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'todo',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            child: RoitButton(
                text: 'ODWOŁAJ', onPressedCallback: () => cancelHelp()),
          ),
          Visibility(
            visible: widget.isAccept,
            child: RoitButton(
                text: 'ZAAKCEPTUJ', onPressedCallback: () => acceptHelp()),
          ),
          Visibility(
            visible: widget.isAccept,
            child: RoitButton(
                text: 'ODRZUĆ', onPressedCallback: () => declineHelp()),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: widget.vote,
        child: FloatingActionButton.extended(
          onPressed: () {
            //vote
          },
          label: Text("Dodaj ocene"),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  cancelHelp() {
    print('cancel help');
  }

  acceptHelp() {
    print('cancel help');
  }

  declineHelp() {
    print('cancel help');
  }
}
