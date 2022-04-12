import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/quick_note_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class NewCheckListViewModel extends BaseViewModel {
  dynamic auth, firestore, user;
  NewCheckListViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    user = ref.watch(authServicesProvider).currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  void newNote(QuickNoteModel quickNote) async {
    bool result = await firestore.addQuickNote(user.uid, quickNote);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
