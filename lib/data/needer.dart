import 'package:helpermate/data/user.dart';

class Needer extends User {
  Needer({
    required String email,
    required String telephone,
    required DateTime dateOfBirth,
    required String address,
    required String fullName,
    required double rate,
    required int amountOdRates,
    required int localization,
  }) : super(
            amountOdRates: amountOdRates,
            rate: rate,
            fullName: fullName,
            email: email,
            localization: localization,
            telephone: telephone,
            dateOfBirth: dateOfBirth,
            address: address);
}
