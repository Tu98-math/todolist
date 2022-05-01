import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/providers/fire_storage_provider.dart';
import 'package:to_do_list/services/auth_services.dart';
import 'package:to_do_list/services/fire_storage_services.dart';

import '/models/task_model.dart';
import '/services/fire_store_services.dart';

import '/base/base_view_model.dart';
import '/models/project_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class NewTaskViewModel extends BaseViewModel {
  final AutoDisposeProviderReference ref;
  late final FirestoreService firestoreService;
  late final AuthenticationService auth;
  late final FireStorageService fireStorageService;
  User? user;

  BehaviorSubject<List<ProjectModel>>? bsListProject =
      BehaviorSubject<List<ProjectModel>>();

  NewTaskViewModel(this.ref) {
    // watch provider
    auth = ref.watch(authServicesProvider);
    user = auth.currentUser();
    firestoreService = ref.watch(firestoreServicesProvider);
    fireStorageService = ref.watch(fireStorageServicesProvider);

    // add project data
    if (user != null) {
      firestoreService.projectStream(user!.uid).listen((event) {
        bsListProject!.add(event);
      });
    }
  }

  Future<String> newTask(TaskModel task, ProjectModel project) async {
    startRunning();
    // add task to database
    String taskID = await firestoreService.addTask(task);
    // add task to project
    await firestoreService.addTaskProject(project, taskID);
    endRunning();
    return taskID;
  }

  Future<void> uploadDesTask(String taskId, String filePath) async {
    startRunning();
    await fireStorageService.uploadTaskImage(filePath, taskId);
    String url = await fireStorageService.loadTaskImage(taskId);
    firestoreService.updateDescriptionUrlTaskById(taskId, url);
    endRunning();
  }

  @override
  void dispose() {
    if (bsListProject != null) {
      bsListProject!.close();
    }
    super.dispose();
  }
}
