import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:image_picker/image_picker.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  File? _image;

  _openGalery(BuildContext context) async {
    try {
      //pobieram zdjęcie z galeri
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      this.setState(() {
        _image = File(image!.path);
      });
      // usuwam okno dialogowe
    } on PlatformException catch (e) {
      print('Failed to pick image: $e ');
    }
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = File(image!.path);
    });
    // usuwam okno dialogowe
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Make a choice'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text('Gallery'),
                onTap: () {
                  _openGalery(context);
                },
              ),
              SizedBox(height: 10.0,),
              GestureDetector(
                child: Text('Camera'),
                onTap: () {
                  _openCamera(context);
                },
              ),
            ],
          )

        ),
      );
    });
  }

  Widget _showImage() {
    if(_image != null) {
      return Image.file(_image!, width: 400,height: 400);
    } else {
      return Text('Please enter photo');
    }
  }

  late String fullName;
  late String email;
  late int helpArea;
  late DateTime dateOdBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0),
          child: Column(
            children: [
              TitleBox(title: "REGISTER"),
              TextInputBox(
                hint: 'Enter your Full Name',
                text: 'Full Name',
                callback: (String value) {fullName = value;},
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
              TextInputBox(
                hint: 'Enter your email',
                text: 'Email',
                callback: (String value) {email = value;},
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              DataPickerBox(
                text: 'Date of birth',
                callback: (DateTime value) {
                  dateOdBirth = value;
                },
              ),
              _image != null ?
              ClipOval(child: Image.file(_image!,width: 300,height: 300, fit: BoxFit.cover)) :
              ClipOval(child: new Container(
                width: 300.0,
                height: 300.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )),
              RaisedButton(
                  child: Text('Pick photo'),
                  onPressed: () {
                      showChoiceDialog(context);
                    },
              ),
            ],
          ),
        ),
      )
    );
  }


}