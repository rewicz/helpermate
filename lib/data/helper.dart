import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/data/user.dart';

class Helper extends UserHelper {

  Helper(
      {required String email,
      required String telephone,
      required DateTime dateOfBirth,
      required String address,
      required GeoPoint? localization,
      required String fullName,
      required int amountOdRates,
      required double rate})
      : super(
            fullName: fullName,
            rate: rate,
            localization: localization,
            amountOdRates: amountOdRates,
            email: email,
            telephone: telephone,
            dateOfBirth: dateOfBirth,
            address: address);
}
