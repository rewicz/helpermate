import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:helpermate/firebase/services/userSecureStorage.dart';

class ImageCloudService {
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: 'gs://helpermate-42e07.appspot.com');


  Future uploadUserPhoto(File? file) async {
    final String? uid = await UserSecureStorage.getUID();

    if(file == null) return;

    final destination = 'usersPhotos/$uid';
    final ref = _storage.ref(destination);

    return ref.putFile(file);
  }

  Future<String> downoladUserPhoto() async {
    final String? uid = await UserSecureStorage.getUID();
    final destination = 'usersPhotos/$uid';
    final ref = _storage.ref(destination);
    final result = await ref.getDownloadURL();

    return result;
  }
}