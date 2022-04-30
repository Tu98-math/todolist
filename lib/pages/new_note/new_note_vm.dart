import '/models/quick_note_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class NewNoteViewModel extends BaseViewModel {
  dynamic auth, firestore, user;
  NewNoteViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  Future<void> newNote(QuickNoteModel quickNote) async {
    startRunning();
    // update new quick note to network
    await firestore.addQuickNote(user.uid, quickNote);
    endRunning();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
