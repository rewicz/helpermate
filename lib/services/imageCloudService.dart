import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:helpermate/services/userSecureStorage.dart';

class ImageCloudService {
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://helpermate-42e07.appspot.com');

  Future uploadUserPhoto(File? file) async {
    final String? uid = await UserSecureStorage.getUID();

    if (file == null) return;

    final destination = 'usersPhotos/$uid';
    final ref = _storage.ref(destination);

    return ref.putFile(file);
  }

  Future<String> downoladUserPhoto() async {
    try {
      final String? uid = await UserSecureStorage.getUID();
      final destination = 'usersPhotos/$uid';

      final ref = _storage.ref(destination);
      final result = await ref.getDownloadURL();
      if (result.length > 0) {
        return result;
      } else {
        return 'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
      }
    } on Exception catch (e) {
      return 'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
    }
  }

  Future<String> downoladUserPhotoByUid(String uid) async {
    try {
      final destination = 'usersPhotos/$uid';

      final ref = _storage.ref(destination);
      final result = await ref.getDownloadURL();
      if (result.length > 0) {
        return result;
      } else {
        return 'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
      }
    } on Exception catch (e) {
      return 'https://firebasestorage.googleapis.com/v0/b/helpermate-42e07.appspot.com/o/iconUser.jpg?alt=media&token=37088170-fcc3-4d29-962e-b2d005d5aec3';
    }
  }
}
