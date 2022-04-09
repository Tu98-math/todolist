import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class SignInViewModel extends BaseViewModel {
  dynamic auth;
  SignInViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }
  BehaviorSubject<SignInStatus> bsLoginStatus =
      BehaviorSubject.seeded(SignInStatus.pause);

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
  }

  void login(String email, String password) async {
    bsLoginStatus.add(SignInStatus.run);
    var status = await auth.signIn(email, password);
    bsLoginStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum SignInStatus {
  pause,
  userNotFound,
  invalidEmail,
  userDisabled,
  wrongPassword,
  networkError,
  run,
  successful
}
