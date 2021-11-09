
import 'package:flutter/material.dart';
import 'package:helpermate/pages/chosenPanel.dart';
import 'package:helpermate/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({Key? key}) : super(key: key);

  @override
  _DecisionTreeState createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {

  User? _user ;


  onRefresh(userSignIn) {
    setState(() {
      _user = userSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    // cały czas zalogowany
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null){
      return Login(onSignIn: (userSignIn) => onRefresh(userSignIn));
    }
    return ChosenPanel(onSignOut: () => onRefresh(null));
  }
}
