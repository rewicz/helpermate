import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/models/userHelper.dart';

class Needer extends UserHelper {
  Needer({
    required String email,
    required String telephone,
    required DateTime dateOfBirth,
    required String address,
    required String fullName,
    required GeoPoint localization,
    required int rate,
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
