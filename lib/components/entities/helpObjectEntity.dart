import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/data/HelpState.dart';

import '../../data/helpTypes.dart';

class HelpObjectEntity {

  String needer;
  List<String>? helpers;
  DateTime helpingTime; // data pomocy
  HelpType helpType;// jaką pomoc jest udzielana
  HelpState helpState; //stan pomocy
  String message;
  String helpingHour;
  String id;
  GeoPoint? place;

  HelpObjectEntity({
      required this.needer,
      required this.place,
      required this.id,
      required this.helpingHour,
      required this.message,
      required this.helpState,
      required this.helpers,
      required this.helpingTime,
      required this.helpType
  });

}