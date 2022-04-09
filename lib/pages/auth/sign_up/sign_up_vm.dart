import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:to_do_list/providers/fire_store_provider.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class SignUpViewModel extends BaseViewModel {
  dynamic auth;
  dynamic firestore;
  SignUpViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  BehaviorSubject<SignUpStatus> bsSignUpStatus =
      BehaviorSubject.seeded(SignUpStatus.pause);

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    firestore = ref.watch(firestoreServicesProvider);
  }

  void signUp(String email, String password) async {
    bsSignUpStatus.add(SignUpStatus.runEmail);
    var status = await auth.signUp(email, password);
    bsSignUpStatus.add(status);
  }

  void createData(String email, String name) async {
    bsSignUpStatus.add(SignUpStatus.runData);
    User? user = auth.currentUser();
    if (user != null) {
      await firestore.addUser(user.uid, email, name);
    }
    bsSignUpStatus.add(SignUpStatus.successfulData);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum SignUpStatus {
  pause,
  emailAlreadyInUse,
  weakPassword,
  operationNotAllowed,
  invalidEmail,
  runEmail,
  successfulEmail,
  runData,
  successfulData
}
