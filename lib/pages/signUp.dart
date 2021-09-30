import 'dart:io';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpermate/components/componentsUI.dart';
import 'package:helpermate/components/settingsPage.dart';
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
  late String password;
  late DateTime dateOdBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SettingPage(),
      appBar: AppBar(
        actions: [ Builder(builder: (context) => IconButton(onPressed: () {
          Scaffold.of(context).openEndDrawer();
        }, icon: Icon(Icons.settings)))],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              TitleBox(title: "Sign up"),
              SizedBox(height: 20.0),
              TextInputBox(
                hint: 'Enter your Full Name',
                text: 'Full Name',
                callback: (String value) {fullName = value;},
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                  validatorMethod: (value) {
                    if(value!.contains(' ')) {
                      return null;
                    } else {
                      return 'Please enter name and surname';
                    }
                  }
              ),
              SizedBox(height: 20.0),
              TextInputBox(
                hint: 'Enter your email',
                text: 'Email',
                callback: (String value) {email = value;},
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                validatorMethod: (value) {
                  if(value!.contains(new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))){
                    return null;
                  } else {
                    return "Wrong email!";
                  }
                },
              ),
              SizedBox(height: 20.0),
              TextInputBox(
                hint: 'Enter your password',
                text: 'Password',
                callback: (String value) {password = value;},
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                validatorMethod: (value) {
                  if(value!.contains(new RegExp(r'^[a-z0-9_-]{4,8}$'))){
                    return null;
                  } else {
                    return "Wrong password!";
                  }
                },
              ),
              SizedBox(height: 20.0),
              DataPickerBox(
                text: 'Date of birth',
                callback: (DateTime value) {
                  dateOdBirth = value;
                },
              ),
              SizedBox(height: 20.0),

              _image != null ?
              ClipOval(child: Image.file(_image!,width: 150,height: 150, fit: BoxFit.cover)) :
              ClipOval(child:
              new Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              ),
              SizedBox(height: 20.0),

              Container(
                width: 100.0,
                height: 50.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () => {showChoiceDialog(context)},
                    child: Text(
                      "Pick photo",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }


}