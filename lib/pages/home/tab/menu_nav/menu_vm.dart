import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/project_model.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';
import '/providers/fire_store_provider.dart';

class MenuViewModel extends BaseViewModel {
  dynamic auth, firestore;
  CollectionReference? project;

  MenuViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    project = ref.watch(projectFirebaseFirestoreProvider);
  }

  Stream<List<ProjectModel>> streamProject() {
    return project!.orderBy('name').snapshots().map((list) =>
        list.docs.map((doc) => ProjectModel.fromFirestore(doc)).toList());
  }

  void addProject(String name, int indexColor) {
    User? user = auth.currentUser();
    if (user != null) {
      var temp = new ProjectModel(
        name: name,
        idAuthor: user.uid,
        countTask: 0,
        indexColor: indexColor,
        timeCreate: DateTime.now(),
      );
      project!.doc().set(temp.toFirestore());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
