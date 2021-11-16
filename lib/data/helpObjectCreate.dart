import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/helpTypes.dart';


class HelpObjectCreate {

  late DateTime helpingTime; // data pomocy
  late HelpType helpType;// jaką pomoc jest udzielana
  late String message;
  String helpingHour = '10.00';
  GeoPoint? localization;

}