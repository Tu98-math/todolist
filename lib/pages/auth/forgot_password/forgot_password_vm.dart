import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  dynamic auth;
  BehaviorSubject<ForgotPasswordStatus> bsForgotPasswordStatus =
      BehaviorSubject.seeded(ForgotPasswordStatus.pause);

  ForgotPasswordViewModel(AutoDisposeProviderReference ref) {
    auth = ref.watch(authServicesProvider);
  }

  void sendRequest(String email) async {
    bsForgotPasswordStatus.add(ForgotPasswordStatus.run);
    var status = await auth.sendRequest(email);
    bsForgotPasswordStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum ForgotPasswordStatus {
  run,
  loading,
  pause,
  invalidEmail,
  userNotFound,
  userDisabled,
  tooManyRequest,
  successful
}
