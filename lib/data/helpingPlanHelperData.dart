class HelpingPlanHelperData {
  int iDHelper; // id pomocnika
  int iDNeeder; // id potrzebującego

  String nameHelper; // imie pomocnika
  String nameNeeder; // imie potrzebującego

  DateTime helpingTime; // data pomocy

  String helpingKind;// jaką pomoc jest udzielana

  HelpingPlanHelperData({
      required this.iDHelper,
      required this.iDNeeder,
      required this.nameHelper,
      required this.nameNeeder,
      required this.helpingTime,
      required this.helpingKind
  });

}