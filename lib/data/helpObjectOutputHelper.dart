import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpermate/data/HelpState.dart';

import '../../data/helpTypes.dart';

class HelpObjectOutputHelper {

  String id;
  String needer;
  DateTime helpingTime; // data pomocy
  HelpType helpType;// jaką pomoc jest udzielana
  HelpState helpState;
  String message;
  double distance;
  GeoPoint? localization;


  HelpObjectOutputHelper({
      required this.needer,
      required this.id,
      required this.distance,
      required this.localization,
      required this.message,
      required this.helpState,
      required this.helpingTime,
      required this.helpType
  });

}