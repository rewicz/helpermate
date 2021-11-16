
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpermate/components/entities/helpObjectEntity.dart';
import 'package:helpermate/components/entities/userEntity.dart';
import 'package:helpermate/data/HelpState.dart';
import 'package:helpermate/data/helpTypes.dart';
import 'package:helpermate/data/helpObjectCreate.dart';
import 'package:helpermate/data/helpObjectOutputHelper.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/data/needer.dart';
import 'package:helpermate/data/user.dart';
import 'package:helpermate/firebase/services/localizationService.dart';
import 'package:helpermate/firebase/services/userSecureStorage.dart';

class FirebaseService {
  final FirebaseFirestore _auth = FirebaseFirestore.instance;

  // 'timestamp': DateTime
  //     .now()
  //     .millisecondsSinceEpoch,

  Future<void> createUserData(String email, String uid) async {
    //todo check login
    try {
      UserEntity newHelper = UserEntity(
          email: email,
          telephone: '',
          dateOfBirth: DateTime.now(),
          address: '',
          fullName: '',
          rate: 0,
          amountOdRates: 0,
          localization: null);
      //todo range
      await _auth.collection('users').doc(uid).set(<String, dynamic>{
        'uid': uid,
        'fullName': newHelper.fullName,
        'email': newHelper.email,
        'telephone': newHelper.telephone,
        'address': newHelper.address,
        'dateOfBirth': newHelper.dateOfBirth,
        'rate': newHelper.rate,
        'amountOdRates': newHelper.amountOdRates,
        'localization': newHelper.localization,
      });
      return;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
      print(e.message);
    }
  }

  Future<void> saveNeederData(Needer user) async {
    //todo check login

    try {
      final name = await UserSecureStorage.getUID() ?? '';
      //todo range
      UserEntity needer = UserEntity(
          fullName: user.fullName,
          email: user.email,
          telephone: user.telephone,
          dateOfBirth: user.dateOfBirth,
          address: user.address,
          rate: user.rate,
          amountOdRates: user.amountOdRates,
          localization: GeoPoint(0, 0));

      _auth.collection('users').doc(name).update(<String, dynamic>{
        'uid': name,
        'fullName': needer.fullName,
        'email': needer.email,
        'telephone': needer.telephone,
        'dateOfBirth': needer.dateOfBirth,
        'address': needer.address,
        'localization': needer.localization,
      });
      return;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<void> saveHelperData(Helper user) async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';
      UserEntity helper = UserEntity(
          fullName: user.fullName,
          email: user.email,
          telephone: user.telephone,
          dateOfBirth: user.dateOfBirth,
          address: user.address,
          rate: 0,
          amountOdRates: 0,
          localization: user.localization);
      _auth.collection('users').doc(name).update(<String, dynamic>{
        'uid': name,
        'fullName': helper.fullName,
        'email': helper.email,
        'telephone': helper.telephone,
        'dateOfBirth': helper.dateOfBirth,
        'address': helper.address,
        'localization': helper.localization,
      });
      print('ok');
      UserSecureStorage.setFullname(helper.fullName);
      return;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<Needer?> readNeederData() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';

      DocumentSnapshot snapshot =
          await _auth.collection('users').doc(name).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        UserEntity neederEntity = UserEntity(
            fullName: data['fullName'],
            email: data['email'],
            telephone: data['telephone'],
            dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
            address: data['address'],
            rate: data['rate'],
            amountOdRates: data['amountOdRates'],
            localization: data['localization']);

        Needer needer = Needer(
            email: neederEntity.email,
            telephone: neederEntity.telephone,
            dateOfBirth: neederEntity.dateOfBirth,
            address: neederEntity.address,
            fullName: neederEntity.fullName,
            amountOdRates: neederEntity.amountOdRates,
            rate: neederEntity.rate, localization: null);
        return needer;
      } else {}
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<UserHelper?> readUserData(String uid) async {
    //todo check login
    try {
      DocumentSnapshot snapshot =
          await _auth.collection('users').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        UserEntity userEntity = UserEntity(
            fullName: data['fullName'],
            email: data['email'],
            telephone: data['telephone'],
            dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
            address: data['address'],
            rate: data['rate'],
            amountOdRates: data['amountOdRates'],
            localization: data['localization']);

        UserHelper user = UserHelper(
            email: userEntity.email,
            telephone: userEntity.telephone,
            dateOfBirth: userEntity.dateOfBirth,
            address: userEntity.address,
            fullName: userEntity.fullName,
            amountOdRates: userEntity.amountOdRates,
            rate: userEntity.rate, localization: userEntity.localization);
        return user;
      } else {}
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<Helper?> readHelperData() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';
      DocumentSnapshot snapshot =
          await _auth.collection('users').doc(name).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        UserEntity helperEntity = UserEntity(
            fullName: data['fullName'],
            email: data['email'],
            telephone: data['telephone'],
            dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
            address: data['address'],
            rate: data['rate'],
            amountOdRates: data['amountOdRates'],
            localization: data['localization']);
        print(helperEntity);
        Helper helper = Helper(
            email: helperEntity.email,
            telephone: helperEntity.telephone,
            dateOfBirth: helperEntity.dateOfBirth,
            address: helperEntity.address,
            fullName: helperEntity.fullName,
            amountOdRates: helperEntity.amountOdRates,
            rate: helperEntity.rate,
            localization: GeoPoint(helperEntity.localization!.latitude,helperEntity.localization!.latitude));

        return helper;
      } else {}
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<void> createHelpObject(HelpObjectCreate helpObject) async {
    //todo check login
    try {
      final id = await UserSecureStorage.getUID() ?? '';
      HelpObjectEntity helpObjectEntity = HelpObjectEntity(
          needer: id,
          helpingHour: helpObject.helpingHour,
          message: helpObject.message,
          helpState: HelpState.FREE,
          helpers: [],
          helpingTime: helpObject.helpingTime,
          helpType: helpObject.helpType,
          place: helpObject.localization,
          id: '');
      _auth.collection('helpObjects').add(<String, dynamic>{
        'needer': helpObjectEntity.needer,
        'helper': helpObjectEntity.helpers,
        'helpingHour': helpObjectEntity.helpingHour,
        'helpState': helpObjectEntity.helpState.name,
        'message': helpObjectEntity.message,
        'helpingTime': helpObjectEntity.helpingTime,
        'helpType': helpObjectEntity.helpType.name,
        'place': helpObjectEntity.place,
        'id': '',
      }).then((value) => _auth
              .collection('helpObjects')
              .doc(value.id)
              .update(<String, dynamic>{
            'id': value.id,
          }));
      return;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<List<HelpObjectOutputHelper>?> readHelpObjectHelper() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';

      //read user data
      Helper? helper = await readHelperData();

      List<HelpObjectEntity> helpObjectEntitiesList = [];

      var snapshot = await _auth.collection('helpObjects').get();
      if (snapshot.docs.isNotEmpty) {
        print(snapshot);
        snapshot.docs.forEach((element) {
          Map<String, dynamic> data = element.data();
          helpObjectEntitiesList.add(HelpObjectEntity(
              needer: data['needer'],
              message: data['message'],
              helpState: HelpState.values
                  .firstWhere((element) => element.name == data['helpState']),
              helpers: data['helpers'],
              helpingTime: (data['helpingTime'] as Timestamp).toDate(),
              helpType: HelpType.values
                  .firstWhere((element) => element.name == data['helpType']),
              place: data['place'],
              helpingHour: data['helpingHour'],
              id: data['helpingHour']));
        });
      }
      List<HelpObjectOutputHelper> helpObjectOutputList = [];
      helpObjectEntitiesList.forEach((element) {
        print(helper);
        double distance = LocalizationService().distanceBetween(element.place!, helper!.localization!);
        helpObjectOutputList.add(HelpObjectOutputHelper(needer: element.needer, id: element.needer, message: element.needer, helpState: element.helpState, helpingTime: element.helpingTime, helpType: element.helpType, localization: element.place, distance: distance));
      });

      return helpObjectOutputList;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }
}
