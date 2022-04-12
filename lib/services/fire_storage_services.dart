import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  final FirebaseStorage _firebaseStorage;

  FireStorageService(this._firebaseStorage);

  uploadAvatar(String filePath, String uid) async {
    File file = File(filePath);
    await _firebaseStorage.ref('user/$uid/avatar.png').putFile(file);
  }

  Future<String> loadAvatar(String uid) {
    return _firebaseStorage.ref('user/$uid/avatar.png').getDownloadURL();
  }
}
