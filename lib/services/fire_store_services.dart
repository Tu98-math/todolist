import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  FirestoreService(this._firebaseFirestore);

  Future<void> addUser(String uid, String email, String name) async {
    _firebaseFirestore.collection('user').doc(uid).set({
      'avatar': '',
      'email': email,
      'name': name,
      'uid': uid,
    });
  }
}
