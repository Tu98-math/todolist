import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class QuickViewModel extends BaseViewModel {
  dynamic fireStore, user;

  BehaviorSubject<List<QuickNoteModel>>? bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  QuickViewModel(AutoDisposeProviderReference ref) {
    user = ref.watch(authServicesProvider).currentUser();
    fireStore = ref.watch(firestoreServicesProvider);
    initListQuickNoteData();
  }

  void initListQuickNoteData() {
    fireStore.quickNoteStream(user.uid).listen((event) {
      bsListQuickNote!.add(event);
    });
  }

  void successfulQuickNote(QuickNoteModel quickNoteModel) {
    // update to local
    quickNoteModel.isSuccessful = true;
    // update to network
    fireStore.updateQuickNote(user.uid, quickNoteModel);
  }

  void checkedNote(QuickNoteModel quickNoteModel, int idNote) {
    // check note
    quickNoteModel.listNote[idNote].check = true;
    // update note to network
    fireStore.updateQuickNote(user.uid, quickNoteModel);
  }

  void deleteNote(QuickNoteModel quickNoteModel) async {
    // delete note in network
    await fireStore.deleteQuickNote(user.uid, quickNoteModel.id);
  }

  @override
  void dispose() {
    bsListQuickNote!.close();
    super.dispose();
  }
}
