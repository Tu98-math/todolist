import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/project_model.dart';

import '../../../models/meta_user_model.dart';
import '/models/task_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';
import '/services/auth_services.dart';
import '/services/fire_store_services.dart';
import '/base/base_view_model.dart';

class DetailTaskViewModel extends BaseViewModel {
  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;
  late final AuthenticationService auth;
  User? user;

  BehaviorSubject<TaskModel?> bsTask = BehaviorSubject<TaskModel?>();

  DetailTaskViewModel(this.ref) {
    // watch provider
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);
  }

  void loadTask(String taskId) {
    firestoreService.taskStreamById(taskId).listen((event) {
      bsTask.add(event);
    });
  }

  Stream<MetaUserModel> getUser(String id) {
    return firestoreService.userStreamById(id);
  }

  Stream<ProjectModel> getProject(String id) {
    return firestoreService.projectStreamById(id);
  }

  void completedTask(String id) async {
    startRunning();
    await firestoreService.completedTaskById(id);
    endRunning();
  }

  @override
  void dispose() {
    bsTask.close();
    super.dispose();
  }
}
