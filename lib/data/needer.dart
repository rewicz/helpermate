
import 'package:helpermate/data/user.dart';

class Needer extends User {

  Needer({required int ID, required String email, required String telephone,
    required String password, required DateTime dateOfBirth, required String address, required String fullName})
      : super(
      ID: ID,
      fullName: fullName,
      email: email,
      telephone: telephone,
      password: password,
      dateOfBirth: dateOfBirth,
      address: address);
}