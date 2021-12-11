import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpTypes.dart';

class HelpObjectEntity {

  String needer;
  List<dynamic>? helpers;
  DateTime helpingTime; // models pomocy
  HelpType helpType;// jaką pomoc jest udzielana
  HelpState helpState; //stan pomocy
  String message;
  String helpingHour;
  String id;
  GeoPoint? place;
  String address;

  HelpObjectEntity({
      required this.needer,
      required this.place,
      required this.address,
      required this.id,
      required this.helpingHour,
      required this.message,
      required this.helpState,
      required this.helpers,
      required this.helpingTime,
      required this.helpType
  });

}