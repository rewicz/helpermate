import 'helpTypes.dart';
import 'helper.dart';
import 'needer.dart';

class HelpObject {

  Needer needer;
  Helper helper;

  DateTime helpingTime; // data pomocy

  HelpType helpType;// jaką pomoc jest udzielana

  HelpObject({
      required this.needer,
      required this.helper,
      required this.helpingTime,
      required this.helpType
  });

}