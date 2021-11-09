import 'package:helpermate/data/user.dart';

class Helper extends User {
  Helper(
      {required String email,
      required String telephone,
      required DateTime dateOfBirth,
      required String address,
      required int localization,
      required String fullName,
      required int amountOdRates,
      required double rate})
      : super(
            fullName: fullName,
            rate: rate,
            amountOdRates: amountOdRates,
            localization: localization,
            email: email,
            telephone: telephone,
            dateOfBirth: dateOfBirth,
            address: address);
}
