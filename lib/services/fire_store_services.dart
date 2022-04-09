import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/quick_note_model.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  FirestoreService(this._firebaseFirestore);

  Future<void> addUser(String uid, String email, String name) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .set({
          'avatar': '',
          'email': email,
          'name': name,
        })
        .then((_) => print('Added'))
        .catchError((error) => print('Add user data failed: $error'));
  }

  Future<void> addQuickNote(String uid, QuickNoteModel quickNote) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc()
        .set(quickNote.toFirestore())
        .then((_) => print('Added'))
        .catchError((error) => print('Add user data failed: $error'));
  }

  Future<void> deleteQuickNote(String uid, QuickNoteModel quickNote) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc(quickNote.id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuickNote(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .snapshots();
  }
}
