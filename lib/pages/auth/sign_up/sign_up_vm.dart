import 'package:to_do_list/providers/fire_store_provider.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class SignUpViewModel extends BaseViewModel {
  dynamic auth, user;
  dynamic fireStore;

  SignUpViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  BehaviorSubject<SignUpStatus> bsSignUpStatus =
      BehaviorSubject.seeded(SignUpStatus.pause);

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
    fireStore = ref.watch(firestoreServicesProvider);
  }

  void signUp(String email, String password) async {
    bsSignUpStatus.add(SignUpStatus.runEmail);
    var status = await auth.signUp(email, password);
    bsSignUpStatus.add(status);
  }

  void createData(String email, String name) async {
    user = auth.currentUser();
    await fireStore.createUserData(user.uid, name, email);
    user.updateDisplayName(name);
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
