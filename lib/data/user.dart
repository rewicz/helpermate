class User {
  String fullName;
  String email;
  String telephone;
  DateTime dateOfBirth;
  String address;
  double rate;
  int amountOdRates;
  int localization;

  User({
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