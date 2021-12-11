import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String fullName;
  String email;
  String telephone;
  DateTime dateOfBirth;
  String address;
  int rate;
  int amountOdRates;
  GeoPoint localization;

  UserEntity({
    required this.fullName,
    required this.localization,
    required this.rate,
    required this.amountOdRates,
    required this.email,
    required this.telephone,
    required this.dateOfBirth,
    required this.address
  });

}