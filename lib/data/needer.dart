import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/data/user.dart';

class Needer extends UserHelper {
  Needer({
    required String email,
    required String telephone,
    required DateTime dateOfBirth,
    required String address,
    required String fullName,
    required GeoPoint? localization,
    required double rate,
    required int amountOdRates,
  }) : super(
            amountOdRates: amountOdRates,
            rate: rate,
            fullName: fullName,
            localization: localization,
            email: email,
            telephone: telephone,
            dateOfBirth: dateOfBirth,
            address: address);
}
