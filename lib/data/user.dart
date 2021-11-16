import 'package:cloud_firestore/cloud_firestore.dart';

class UserHelper {
  String fullName;
  String email;
  String telephone;
  DateTime dateOfBirth;
  String address;
  double rate;
  int amountOdRates;
  GeoPoint? localization;


  UserHelper({
    required this.fullName,
    required this.rate,
    required this.amountOdRates,
    required this.email,
    required this.telephone,
    required this.dateOfBirth,
    required this.localization,
    required this.address,
  });

}