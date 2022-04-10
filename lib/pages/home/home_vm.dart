import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_view_model.dart';
import '/providers/fire_store_provider.dart';
import '/providers/auth_provider.dart';

class HomeViewModel extends BaseViewModel {
  dynamic auth, firestore;

  Stream<QuerySnapshot<Map<String, dynamic>>>? quickNoteStream;

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
