import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list/models/project_model.dart';
import 'package:to_do_list/models/quick_note_model.dart';

import '../constants/app_colors.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;
  FirestoreService(this._firebaseFirestore);

  Stream<List<QuickNoteModel>> quickNoteStream(String uid) {
    return _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .orderBy('time', descending: true)
        .snapshots()
        .map(
          (list) => list.docs
              .map((doc) => QuickNoteModel.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<ProjectModel>> projectStream(String uid) {
    return _firebaseFirestore
        .collection('project')
        .where('id_author', isEqualTo: uid)
        .snapshots()
        .map(
          (list) => list.docs.map((doc) {
            DocumentReference<Map<String, dynamic>> map = doc['author'];
            map.get().then((DocumentSnapshot doc) {
              if (doc.exists) {
                print('Document exists on the database');
              }
              print(doc['name']);
            });
            return ProjectModel.fromFirestore(doc);
          }).toList(),
        );
  }

  Future<bool> addQuickNote(String uid, QuickNoteModel quickNote) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc()
        .set(quickNote.toFirestore())
        .then((_) {
      servicesResultPrint('Added quick note');

      return true;
    }).catchError((error) {
      servicesResultPrint('Add quick note failed: $error');
      return false;
    });
    return false;
  }

  Future<bool> deleteQuickNote(String uid, String id) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc(id)
        .delete()
        .then((value) {
      servicesResultPrint("Quick note Deleted");
      return true;
    }).catchError((error) {
      servicesResultPrint("Failed to delete quick note: $error");
      return false;
    });
    return false;
  }

  Future<bool> updateQuickNote(
      String uid, QuickNoteModel quickNoteModel) async {
    await _firebaseFirestore
        .collection('user')
        .doc(uid)
        .collection('quick_note')
        .doc(quickNoteModel.id)
        .set(quickNoteModel.toFirestore())
        .then((value) {
      servicesResultPrint("Quick note updated");
      return true;
    }).catchError((onError) {
      servicesResultPrint("Failed to update quick note: $onError");
      return false;
    });
    return false;
  }

  void addProject(ProjectModel project) {
    _firebaseFirestore.collection('project').doc().set(project.toFirestore());
  }

  Future<void> createUserData(
      String uid, String displayName, String email) async {
    await _firebaseFirestore.collection('user').doc(uid).set({
      'displayName': displayName,
      'email': email,
    }).then((value) {
      servicesResultPrint('Create user data successful', isToast: false);
    });
  }

  Future<void> updateUserAvatar(String uid, String url) async {
    await _firebaseFirestore.collection('user').doc(uid).update({
      'url': url,
    }).then((value) {
      servicesResultPrint('Update avatar successful', isToast: false);
    });
  }

  void servicesResultPrint(String result, {bool isToast = true}) async {
    print("FirebaseStore services result: $result");
    if (isToast)
      await Fluttertoast.showToast(
        msg: result,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.kWhiteBackground,
        textColor: AppColors.kText,
      );
  }
}
