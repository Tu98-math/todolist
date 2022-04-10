import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list/models/quick_note_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class ProfileViewModel extends BaseViewModel {
  dynamic auth, firestore;
  CollectionReference? quickNote;
  User? user;

  BehaviorSubject<infoStatus> bsInfoStatus = BehaviorSubject.seeded(infoStatus.info);

  ProfileViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    quickNote = ref.watch(quickFirebaseFirestoreProvider);
  }

  Stream<List<QuickNoteModel>>? streamQuickNote() {
    if (quickNote != null)
      return quickNote!.orderBy('time').snapshots().map((list) =>
          list.docs.map((doc) => QuickNoteModel.fromFirestore(doc)).toList());
    else
      return null;
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
