import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list/providers/fire_storage_provider.dart';

import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class ProfileViewModel extends BaseViewModel {
  dynamic auth, user, fireStore, fireStorage;

  BehaviorSubject<infoStatus> bsInfoStatus =
      BehaviorSubject.seeded(infoStatus.info);

  BehaviorSubject<List<QuickNoteModel>>? bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  ProfileViewModel(AutoDisposeProviderReference ref) {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    fireStore = ref.watch(firestoreServicesProvider);
    fireStorage = ref.read(fireStorageServicesProvider);

    initListQuickNoteData();
  }

  void initListQuickNoteData() {
    fireStore.quickNoteStream(user.uid).listen((event) {
      bsListQuickNote!.add(event);
    });
  }

  Stream<List<QuickNoteModel>> streamQuickNote() {
    return fireStore.quickNoteStream(user.uid);
  }

  void uploadAvatar(String filePath) async {
    await fireStorage.uploadAvatar(filePath, user.uid);
    String url = await fireStorage.loadAvatar(user.uid);
    user.updatePhotoURL(url);
    fireStore.updateUserAvatar(user.uid, url);
    bsInfoStatus.add(infoStatus.info);
  }

  Stream<User?> getUser() {
    return auth.authStateChange;
  }

  void signOut() {
    auth.signOut();
  }

  void changeInfoStatus(infoStatus status) {
    bsInfoStatus.add(status);
  }

  @override
  void dispose() {
    bsListQuickNote!.close();
    bsInfoStatus.close();
    super.dispose();
  }
}

enum infoStatus { info, setting }
