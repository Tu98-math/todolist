import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class WelcomeViewModel extends BaseViewModel {
  BehaviorSubject<InitialStatus> bsInitSate =
      BehaviorSubject.seeded(InitialStatus.loading);
  dynamic authState;

  WelcomeViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) {
    authState = ref.watch(authStateProvider);
    authState.when(
      data: (value) {
        if (value != null) {
          bsInitSate.add(InitialStatus.home);
        } else {
          bsInitSate.add(InitialStatus.onBoarding);
        }
      },
      loading: () {
        bsInitSate.add(InitialStatus.loading);
      },
      error: (_, __) {
        bsInitSate.add(InitialStatus.error);
      },
    );
  }

  @override
  void dispose() {
    bsInitSate.close();
    super.dispose();
  }
}

enum InitialStatus { onBoarding, home, loading, error }
