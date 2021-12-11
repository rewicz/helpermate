import 'package:helpermate/models/userHelper.dart';

class HelperToAccept {
  String fullname;
  DateTime dateOfBirth;
  int amountOdRates;
  String uid;
  int rate;

  HelperToAccept(
      {required this.fullname,
      required this.dateOfBirth,
      required this.uid,
      required this.amountOdRates,
      required this.rate});
}
