import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/helpTypes.dart';


class HelpObjectCreate {

  late DateTime helpingTime = DateTime.now(); // models pomocy
  late HelpType helpType;// jaką pomoc jest udzielana
  late String message;
  String helpingHour = '10.00';
  GeoPoint? localization;

}