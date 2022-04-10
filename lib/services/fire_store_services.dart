import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/models/project_model.dart';
import 'package:to_do_list/models/quick_note_model.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  FirestoreService(this._firebaseFirestore);

  Stream<List<QuickNoteModel>> quickNoteStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .where('is_successful', isEqualTo: false)
        .snapshots()
        .map(
          (list) => list.docs
              .map((doc) => QuickNoteModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<QuickNoteModel>> quickNoteFullStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .snapshots()
        .map(
          (list) => list.docs
              .map((doc) => QuickNoteModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<int> noteLengthStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .where('list.length', isEqualTo: 0)
        .snapshots()
        .map(
          (list) => list.docs.map((doc) => doc).toList().length,
        );
  }

  Stream<int> noteSuccessfulLengthStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .where('list.length', isEqualTo: 0)
        .where('is_successful', isEqualTo: true)
        .snapshots()
        .map(
          (list) => list.docs.map((doc) => doc).toList().length,
        );
  }

  Stream<int> checkListLengthStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .where('list.length', isNotEqualTo: 0)
        .snapshots()
        .map(
          (list) => list.docs.map((doc) => doc).toList().length,
        );
  }

  Stream<int> checkListSuccessfulLengthStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .where('list.length', isNotEqualTo: 0)
        .where('is_successful', isEqualTo: true)
        .snapshots()
        .map(
          (list) => list.docs.map((doc) => doc).toList().length,
        );
  }

  Stream<List<ProjectModel>> projectStream(String uid) {
    return _firebaseFirestore
        .collection('project')
        .where('id_author', isEqualTo: uid)
        .snapshots()
        .map(
          (list) => list.docs
              .map(
                (doc) => ProjectModel.fromFirestore(doc),
              )
              .toList(),
        );
  }

  Future<void> addQuickNote(String uid, QuickNoteModel quickNote) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc()
        .set(quickNote.toFirestore())
        .then((_) => print('Added'))
        .catchError(
          (error) => print('Add user data failed: $error'),
        );
  }

  Future<void> deleteQuickNote(String uid, String id) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateQuickNote(
      String uid, QuickNoteModel quickNoteModel) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc(quickNoteModel.id)
        .set(quickNoteModel.toFirestore());
  }



  void addProject(ProjectModel project) {
    _firebaseFirestore.collection('project').doc().set(project.toFirestore());
  }
}
