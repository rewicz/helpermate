import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpermate/components/entities/userEntity.dart';
import 'package:helpermate/data/helper.dart';
import 'package:helpermate/data/needer.dart';
import 'package:helpermate/firebase/services/userSecureStorage.dart';

class FirebaseService {
  final FirebaseFirestore _auth = FirebaseFirestore.instance;

  // 'timestamp': DateTime
  //     .now()
  //     .millisecondsSinceEpoch,

  Future<void> createUserData() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';
      UserEntity newHelper = UserEntity(email: '', telephone: '', dateOfBirth: DateTime.now(), address: '', fullName: '',rate: 0, amountOdRates: 0);
      //todo range
      await _auth.collection('users').doc(name).set(<String, dynamic>{
        'uid': name,
        'fullName': newHelper.fullName,
        'email': newHelper.email,
        'telephone': newHelper.telephone,
        'address': newHelper.address,
        'dateOfBirth': newHelper.dateOfBirth,
        'rate': newHelper.rate,
        'amountOdRates': newHelper.amountOdRates,
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
      UserEntity needer = UserEntity(fullName: user.fullName, email: user.email, telephone: user.telephone, dateOfBirth: user.dateOfBirth, address: user.address, rate: 0, amountOdRates: 0);

      _auth.collection('users').doc(name).update(<String, dynamic>{
        'uid': name,
        'fullName': needer.fullName,
        'email': needer.email,
        'telephone': needer.telephone,
        'dateOfBirth': needer.dateOfBirth,
        'address': needer.address,
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
      UserEntity helper = UserEntity(fullName: user.fullName, email: user.email, telephone: user.telephone, dateOfBirth: user.dateOfBirth, address: user.address, rate: 0, amountOdRates: 0);
      _auth.collection('users').doc(name).update(<String, dynamic>{
        'uid': name,
        'fullName': helper.fullName,
        'email': helper.email,
        'telephone': helper.telephone,
        'dateOfBirth': helper.dateOfBirth,
        'address': helper.address,
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

      DocumentSnapshot snapshot = await _auth.collection('users').doc(name).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        UserEntity neederEntity = UserEntity(fullName: data['fullName'], email: data['email'], telephone: data['telephone'], dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(), address: data['address'], rate: data['rate'], amountOdRates: data['amountOdRates']);

        Needer needer = Needer(email: neederEntity.email, telephone: neederEntity.telephone, dateOfBirth: neederEntity.dateOfBirth, address: neederEntity.address, fullName: neederEntity.fullName, amountOdRates: neederEntity.amountOdRates, rate: neederEntity.rate);
        return needer;

      } else {

      }

    } on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

  Future<Helper?> readHelperData() async {
    //todo check login
    try {
      final name = await UserSecureStorage.getUID() ?? '';
      DocumentSnapshot snapshot = await _auth.collection('users').doc(name).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        UserEntity helperEntity = UserEntity(fullName: data['fullName'], email: data['email'], telephone: data['telephone'], dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(), address: data['address'], rate: data['rate'], amountOdRates: data['amountOdRates']);

        Helper helper = Helper(email: helperEntity.email, telephone: helperEntity.telephone, dateOfBirth: helperEntity.dateOfBirth, address: helperEntity.address, fullName: helperEntity.fullName, amountOdRates: helperEntity.amountOdRates, rate: helperEntity.rate);
        return helper;

      } else {

      }} on FirebaseException catch (e) {
      print('Nie można połączyć się z bazą');
    }
  }

}