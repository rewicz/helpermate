import '../../models/helpTypes.dart';
import '../../models/helper.dart';
import '../../models/needer.dart';
import 'HelpState.dart';

class HelpObjectInput {

  String id;
  Needer needer;
  List<Helper> helper;
  DateTime helpingTime; // models pomocy
  HelpType helpType;// jaką pomoc jest udzielana
  HelpState helpState; //stan pomocy
  String message;


  HelpObjectInput({
      required this.needer,
      required this.id,
      required this.message,
      required this.helpState,
      required this.helper,
      required this.helpingTime,
      required this.helpType
  });

}