import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpermate/models/entities/helpObjectEntity.dart';
import 'package:helpermate/models/entities/userEntity.dart';
import 'package:helpermate/models/HelpState.dart';
import 'package:helpermate/models/helpTypes.dart';
import 'package:helpermate/models/helpObjectCreate.dart';
import 'package:helpermate/models/helpObjectOutputHelper.dart';
import 'package:helpermate/models/helper.dart';
import 'package:helpermate/models/helperToAccept.dart';
import 'package:helpermate/models/needer.dart';
import 'package:helpermate/models/userHelper.dart';
import 'package:helpermate/services/localizationService.dart';
import 'package:helpermate/services/userSecureStorage.dart';

class FirebaseService {
  final FirebaseFirestore _auth = FirebaseFirestore.instance;

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
          localization: GeoPoint(0, 0));
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
      UserSecureStorage.setFullname('użytkowniku');
      List<String> temp = [];

      _auth.collection('rates').doc(uid).set(<String, dynamic>{
        'date': temp,
        'rate': temp,
        'message': temp,
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
            rate: neederEntity.rate,
            localization: GeoPoint(0, 0));
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
            rate: userEntity.rate,
            localization: userEntity.localization);
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
            localization: GeoPoint(helperEntity.localization.latitude,
                helperEntity.localization.latitude));

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
      UserHelper? userHelper = await readUserData(id);
      HelpObjectEntity helpObjectEntity = HelpObjectEntity(
          needer: id,
          helpingHour: helpObject.helpingHour,
          message: helpObject.message,
          helpState: HelpState.FREE,
          helpers: [],
          helpingTime: helpObject.helpingTime,
          helpType: helpObject.helpType,
          place: userHelper!.localization,
          id: '',
          address: userHelper.address);
      _auth.collection('helpObjects').add(<String, dynamic>{
        'needer': helpObjectEntity.needer,
        'helpers': helpObjectEntity.helpers,
        'helpingHour': helpObjectEntity.helpingHour,
        'helpState': helpObjectEntity.helpState.name,
        'message': helpObjectEntity.message,
        'helpingTime': helpObjectEntity.helpingTime,
        'helpType': helpObjectEntity.helpType.name,
        'place': helpObjectEntity.place,
        'address': helpObjectEntity.address,
        'id': helpObjectEntity.id,
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

  Future<List<HelpObjectOutputHelper>?> readAllNotMYHelpObject() async {
    //todo check login
    try {
      final String name = await UserSecureStorage.getUID() ?? '';

      //read user models
      Helper? helper = await readHelperData();

      List<HelpObjectEntity> helpObjectEntitiesList = [];

      var snapshot = await _auth.collection('helpObjects').where('helpState',
          whereIn: [HelpState.FREE.name, HelpState.ACCEPTABLE.name]).get();
      if (snapshot.docs.isNotEmpty) {
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
              id: data['id'],
              address: data['address']));
        });
      }
      helpObjectEntitiesList.removeWhere((element) => element.needer == name);

      List<HelpObjectEntity> helpObjectFilterList = [];
      bool test;
      helpObjectEntitiesList.forEach((element) {
        if (element.helpers!.isNotEmpty) {
          test = false;
          element.helpers!.forEach((element2) {
            if (element2 == name) {
              // nieeeeeeeeeeeeee
              test = true;
            }
          });
          if (!test) {
            helpObjectFilterList.add(element);
          }
        } else {
          helpObjectFilterList.add(element);
        }
      });

      List<HelpObjectOutputHelper> helpObjectOutputList = [];
      helpObjectFilterList.forEach((element) {
        double distance = LocalizationService()
            .distanceBetween(element.place!, helper!.localization);
        helpObjectOutputList.add(HelpObjectOutputHelper(
            needer: element.needer,
            id: element.id,
            message: element.message,
            helpState: element.helpState,
            helpingTime: element.helpingTime,
            helpType: element.helpType,
            localization: element.place,
            distance: distance,
            helpers: element.helpers!.cast<String>(),
            helpingHour: element.helpingHour,
            address: element.address));
      });

      return helpObjectOutputList;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<List<HelpObjectOutputHelper>?> readMyHelpObject() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';

      //read user models
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
              helpers: List.from(data['helpers']),
              helpingTime: (data['helpingTime'] as Timestamp).toDate(),
              helpType: HelpType.values
                  .firstWhere((element) => element.name == data['helpType']),
              place: data['place'],
              helpingHour: data['helpingHour'],
              id: data['id'],
              address: data['address']));
        });
      }

      List<HelpObjectEntity> helpObjectFilterList = [];
      helpObjectEntitiesList.forEach((element) {
        if (element.helpers != null) {
          element.helpers!.forEach((element2) {
            if (element2 == name) {
              helpObjectFilterList.add(element);
            }
          });
        }
      });

      List<HelpObjectOutputHelper> helpObjectOutputList = [];
      helpObjectFilterList.forEach((element) {
        print(helper);
        double distance = LocalizationService()
            .distanceBetween(element.place!, helper!.localization);

        helpObjectOutputList.add(HelpObjectOutputHelper(
            needer: element.needer,
            id: element.id,
            message: element.message,
            helpState: element.helpState,
            helpingTime: element.helpingTime,
            helpType: element.helpType,
            localization: element.place,
            distance: distance,
            helpers: element.helpers!.cast<String>(),
            helpingHour: element.helpingHour,
            address: element.address));
      });

      return helpObjectOutputList;
    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<List<HelpObjectOutputHelper>?> acceptHelpByHelper(
      HelpObjectOutputHelper helpObject) async {
    final name = await UserSecureStorage.getUID() ?? '';
    helpObject.helpers!.add(name);
    _auth.collection('helpObjects').doc(helpObject.id).update(<String, dynamic>{
      'helpState': HelpState.ACCEPTABLE.name,
      'helpers': helpObject.helpers,
    });
  }

  Future<List<HelpObjectOutputHelper>?> declineHelpByHelper(
      HelpObjectOutputHelper helpObject) async {
    final name = await UserSecureStorage.getUID() ?? '';
    helpObject.helpers!.remove(name);
    _auth.collection('helpObjects').doc(helpObject.id).update(<String, dynamic>{
      'helpers': helpObject.helpers,
      'helpState': helpObject.helpers!.isEmpty
          ? HelpState.FREE.name
          : HelpState.ACCEPTABLE.name,
    });
  }

  Future<List<HelpObjectOutputHelper>?> deleteHelp(String id) async {
    _auth.collection('helpObjects').doc(id).delete();
  }

  Future<List<HelperToAccept>?> getHelpersToAccept(
      List<String>? helpers) async {
    List<HelperToAccept> helpersOutput = [];
    var snapshot =
        await _auth.collection('users').where('uid', whereIn: helpers).get();

    snapshot.docs.forEach((element) {
      helpersOutput.add(new HelperToAccept(
          fullname: element.data()['fullName'],
          dateOfBirth:  (element.data()['dateOfBirth'] as Timestamp).toDate(),
          amountOdRates: element.data()['amountOdRates'],
          rate: element.data()['rate'], uid: element.data()['uid']));
    });

    return helpersOutput;
  }

  Future<void> acceptHelpByNeeder(String helper, String help) async {

    List<String> temp = [helper];

    _auth.collection('helpObjects').doc(help).update(<String, dynamic>{
      'helpState': HelpState.GOOD.name,
      'helpers': temp,
    });
  }

  Future<void> finishHelp(HelpObjectOutputHelper helpObject) async {
    _auth.collection('helpObjects').doc(helpObject.id).update(<String, dynamic>{
      'helpState': HelpState.RATING.name,
    });

    _auth.collection('archive').add(<String, dynamic>{
      'needer': helpObject.needer,
      'person': helpObject.needer,
      'helper': helpObject.helpers!.first,
      'helpingHour': helpObject.helpingHour,
      'helpState': HelpState.ARCHIVE.name,
      'message': helpObject.message,
      'helpingTime': helpObject.helpingTime,
      'helpType': helpObject.helpType.name,
      'address': helpObject.address,
      'id': helpObject.id,
    });

    _auth.collection('archive').add(<String, dynamic>{
      'needer': helpObject.needer,
      'person': helpObject.helpers!.first,
      'helper': helpObject.helpers!.first,
      'helpingHour': helpObject.helpingHour,
      'helpState': HelpState.ARCHIVE.name,
      'message': helpObject.message,
      'helpingTime': helpObject.helpingTime,
      'helpType': helpObject.helpType.name,
      'address': helpObject.address,
      'id': helpObject.id,
    });

  }

  Future<void> sendHelperRate(double rate, String message, HelpObjectOutputHelper helpObject) async {

    var snapshotUserData = await _auth.collection('users').doc(helpObject.helpers!.first).get();
    if (snapshotUserData.exists) {
      Map<String, dynamic> data = snapshotUserData.data() as Map<String, dynamic>;
      int rateOld = data['rate'];
      int amountOfRates = data['amountOdRates'];

      double newRate = (rateOld * amountOfRates + rate)/ (amountOfRates+1);

      _auth.collection('users').doc(helpObject.helpers!.first).update(<String, dynamic>{
        'rate' : newRate.toInt(),
        'amountOdRates': ++amountOfRates,
      });
    }


    if(helpObject.helpState == HelpState.RATINGNEEDER){
      _auth.collection('helpObjects').doc(helpObject.id).delete();
    } else {
      _auth.collection('helpObjects').doc(helpObject.id).update(<String, dynamic>{
        'helpState': HelpState.RATINGHELPER.name,
      });
    }
    var snapshot =
        await _auth.collection('rates').doc(helpObject.helpers!.first).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> messengesData = data['message'];
      List<dynamic> ratesData = data['rate'];
      List<dynamic> datesData = data['date'];

      List<String> messenges = messengesData.cast<String>();
      List<double> rates = ratesData.cast<double>();
      List<Timestamp> dates = datesData.cast<Timestamp>();
      List<DateTime> datesGood = [];

      dates.forEach((element) {datesGood.add(element.toDate());});

      messenges.add(message);
      rates.add(rate);
      datesGood.add(DateTime.now());

      _auth.collection('rates').doc(helpObject.helpers!.first).update(<String, dynamic>{
        'uid' : helpObject.helpers!.first,
        'message': messenges,
        'rate': rates,
        'date': datesGood,
      });
    }
  }

  Future<void> sendNeederRate(double rate, String message, HelpObjectOutputHelper helpObject) async {

    var snapshotUserData = await _auth.collection('users').doc(helpObject.needer).get();
    if (snapshotUserData.exists) {
      Map<String, dynamic> data = snapshotUserData.data() as Map<String, dynamic>;
      int rateOld = data['rate'];
      int amountOfRates = data['amountOdRates'];

      double newRate = (rateOld * amountOfRates + rate) / (amountOfRates+1);


      _auth.collection('users').doc(helpObject.needer).update(<String, dynamic>{
        'rate' : newRate.toInt(),
        'amountOdRates': ++amountOfRates,
      });
    }


    if(helpObject.helpState == HelpState.RATINGHELPER){
      _auth.collection('helpObjects').doc(helpObject.id).delete();
    } else {
      _auth.collection('helpObjects').doc(helpObject.id).update(<String, dynamic>{
        'helpState': HelpState.RATINGNEEDER.name,
      });
    }
    var snapshot =
        await _auth.collection('rates').doc(helpObject.needer).get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> messengesData = data['message'];
      List<dynamic> ratesData = data['rate'];
      List<dynamic> datesData = data['date'];

      List<String> messenges = messengesData.cast<String>();
      List<double> rates = ratesData.cast<double>();
      List<Timestamp> dates = datesData.cast<Timestamp>();
      List<DateTime> datesGood = [];

      dates.forEach((element) {datesGood.add(element.toDate());});

      messenges.add(message);
      rates.add(rate);
      datesGood.add(DateTime.now());

      _auth.collection('rates').doc(helpObject.needer).update(<String, dynamic>{
        'uid' : helpObject.needer,
        'message': messenges,
        'rate': rates,
        'date': datesGood,
      });
    }
  }
}
