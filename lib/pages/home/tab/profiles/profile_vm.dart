import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class ProfileViewModel extends BaseViewModel {
  dynamic auth, user, firestore;

  BehaviorSubject<infoStatus> bsInfoStatus =
      BehaviorSubject.seeded(infoStatus.info);

  ProfileViewModel(AutoDisposeProviderReference ref) {
    auth = ref.watch(authServicesProvider);
    user = ref.watch(authServicesProvider).currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  Stream<List<QuickNoteModel>> streamQuickNote() {
    return firestore.quickNoteFullStream(user.uid);
  }

  void signOut() {
    auth.signOut();
  }

  void changeInfoStatus(infoStatus status) {
    bsInfoStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum infoStatus { info, setting }
