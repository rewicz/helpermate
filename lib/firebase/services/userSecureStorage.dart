
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helpermate/models/userState.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyFullname = 'FULLNAME';
  static const _uid = 'UID';
  static const _userState = 'STATE';

  static Future setFullname(String fullname) async =>
      await _storage.write(key: _keyFullname, value: fullname);

  static Future<String?> getFullname() async =>
      await _storage.read(key: _keyFullname) ?? '';

  static Future setUID(String uid) async =>
      await _storage.write(key: _uid, value: uid);

  static Future<String?> getUID() async =>
      await _storage.read(key: _uid);

  static Future setUserState(UserState userState) async =>
      await _storage.write(key: _userState, value: userState.toString());

  static Future<UserState?> getUserState() async =>
      await _storage.read(key: _userState).then((value) => UserState.values.firstWhere((element) => value == element.toString()));

  static void reset() async =>
      await _storage.deleteAll();

}