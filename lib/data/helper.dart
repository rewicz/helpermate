import 'package:helpermate/data/user.dart';

class Helper extends User {

  int range;

  Helper(
      {required int ID,
      required String email,
      required String telephone,
      required String password,
      required DateTime dateOfBirth,
      required String address,
      required this.range,
      required String fullName})
      : super(
            ID: ID,
            fullName: fullName,
            email: email,
            telephone: telephone,
            password: password,
            dateOfBirth: dateOfBirth,
            address: address);
}
