import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/models/HelpState.dart';

import '../../models/helpTypes.dart';

class HelpObjectArchive {

  String id;
  String needer;
  DateTime helpingTime; // models pomocy
  HelpType helpType;// jaką pomoc jest udzielana
  HelpState helpState;
  String message;
  double distance;
  GeoPoint? localization;
  String helper;
  String helpingHour;
  String address;

  HelpObjectArchive({
      required this.needer,
      required this.address,
      required this.helper,
      required this.id,
      required this.helpingHour,
      required this.distance,
      required this.localization,
      required this.message,
      required this.helpState,
      required this.helpingTime,
      required this.helpType
  });

}