import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class HomeViewModel extends BaseViewModel {
  dynamic auth;

  HomeViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
  }

  void logOut() {
    auth.logOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum tabStatus { myTask, menu, quick, profile }
