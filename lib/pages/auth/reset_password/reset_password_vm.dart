import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class ResetPasswordViewModel extends BaseViewModel {
  dynamic auth;
  BehaviorSubject<ResetPasswordStatus> bsResetPasswordStatus =
      BehaviorSubject.seeded(ResetPasswordStatus.pause);

  ResetPasswordViewModel(AutoDisposeProviderReference ref) {
    auth = ref.watch(authServicesProvider);
  }

  void changePassword(String code, String password) async {
    bsResetPasswordStatus.add(ResetPasswordStatus.run);
    var status = await auth.changePassword(code, password);
    bsResetPasswordStatus.add(status);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum ResetPasswordStatus {
  run,
  loading,
  pause,
  invalidActionCode,
  userNotFound,
  userDisabled,
  expiredActionCode,
  weakPassword,
  successful
}
