import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/subjects.dart';

import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class HomeViewModel extends BaseViewModel {
  dynamic auth, firestore;

  BehaviorSubject<List<QuickNoteModel>>? bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  HomeViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    firestore = ref.watch(firestoreServicesProvider);
  }

  void logOut() {
    auth.logOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum tabStatus { myTask, menu, quick, profile }
