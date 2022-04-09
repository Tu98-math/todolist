import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/quick_note_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class QuickViewModel extends BaseViewModel {
  dynamic auth, firestore;
  CollectionReference? quickNote;

  QuickViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    quickNote = ref.watch(quickFirebaseFirestoreProvider);
    streamQuickNote();
  }

  Stream<List<QuickNoteModel>>? streamQuickNote() {
    if (quickNote != null)
      return quickNote!.orderBy('time').snapshots().map((list) =>
          list.docs.map((doc) => QuickNoteModel.fromFirestore(doc)).toList());
    else
      return null;
  }

  void deleteQuickNote(String id) {
    if (quickNote != null) {
      quickNote!
          .doc(id)
          .delete()
          .then((value) => print("User Deleted"))
          .catchError(
            (error) => print("Failed to delete user: $error"),
          );
    }
  }

  void checkedNote(QuickNoteModel quickNoteModel, int idNote) {
    quickNoteModel.listNote[idNote].check = true;
    if (quickNote != null) {
      quickNote!.doc(quickNoteModel.id).set(quickNoteModel.toFirestore());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
