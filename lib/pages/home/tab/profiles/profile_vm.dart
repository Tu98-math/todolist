import 'package:firebase_auth/firebase_auth.dart';

import '/providers/fire_storage_provider.dart';
import '/services/auth_services.dart';
import '/services/fire_storage_services.dart';
import '/services/fire_store_services.dart';

import '/models/task_model.dart';
import '/base/base_view_model.dart';
import '/models/quick_note_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class ProfileViewModel extends BaseViewModel {
  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;
  late final FireStorageService fireStorageService;
  late final AuthenticationService auth;
  User? user;

  BehaviorSubject<infoStatus> bsInfoStatus =
      BehaviorSubject.seeded(infoStatus.info);

  BehaviorSubject<List<QuickNoteModel>?> bsListQuickNote =
      BehaviorSubject<List<QuickNoteModel>>();

  BehaviorSubject<List<TaskModel>?> bsListTask =
      BehaviorSubject<List<TaskModel>>();

  ProfileViewModel(this.ref) {
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);
    fireStorageService = ref.read(fireStorageServicesProvider);

    if (user != null)
      firestoreService.quickNoteStream(user!.uid).listen((event) {
        bsListQuickNote.add(event);
      });

    firestoreService.taskStream().listen((event) {
      List<TaskModel> listAllData = event;
      List<TaskModel> listData = [];
      for (var task in listAllData) {
        if (task.idAuthor == user!.uid || task.listMember.contains(user!.uid)) {
          listData.add(task);
        }
      }
      listData.sort((a, b) => a.dueDate.compareTo(b.dueDate));
      bsListTask.add(listData);
    });
  }

  void uploadAvatar(String filePath) async {
    await fireStorageService.uploadAvatar(filePath, user!.uid);
    String url = await fireStorageService.loadAvatar(user!.uid);
    user!.updatePhotoURL(url);
    firestoreService.updateUserAvatar(user!.uid, url);
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
    bsListQuickNote.close();
    bsListTask.close();
    bsInfoStatus.close();
    super.dispose();
  }
}

enum infoStatus { info, setting }
