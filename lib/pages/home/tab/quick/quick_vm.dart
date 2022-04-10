import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/quick_note_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class QuickViewModel extends BaseViewModel {
  dynamic firestore, user;

  QuickViewModel(AutoDisposeProviderReference ref) {
    user = ref.watch(authServicesProvider).currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  void init(var ref) async {
    user = ref.watch(authServicesProvider).currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  Stream<List<QuickNoteModel>> streamQuickNote() {
    return firestore.quickNoteStream(user.uid);
  }

  void successfulQuickNote(QuickNoteModel quickNoteModel) {
    quickNoteModel.isSuccessful = true;

    firestore.updateQuickNote(user.uid, quickNoteModel);
  }

  void checkedNote(QuickNoteModel quickNoteModel, int idNote) {
    quickNoteModel.listNote[idNote].check = true;

    firestore.updateQuickNote(user.uid, quickNoteModel);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
