import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/project_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class MenuViewModel extends BaseViewModel {
  dynamic user, firestore;

  MenuViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    user = ref.watch(authServicesProvider).currentUser();
    firestore = ref.watch(firestoreServicesProvider);
  }

  Stream<List<ProjectModel>> streamProject() {
    return firestore.projectStream(user.uid);
  }

  void addProject(String name, int indexColor) {
    var temp = new ProjectModel(
      name: name,
      idAuthor: user.uid,
      countTask: 0,
      indexColor: indexColor,
      timeCreate: DateTime.now(),
    );
    firestore.addProject(temp);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
