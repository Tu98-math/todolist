import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class WelcomeViewModel extends BaseViewModel {
  BehaviorSubject<InitialStatus> bsInitSate =
      BehaviorSubject.seeded(InitialStatus.loading);
  dynamic auth;

  WelcomeViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) {
    auth = ref.watch(authStateProvider);
    auth.when(
      data: (value) {
        if (value != null) {
          bsInitSate.add(InitialStatus.home);
        } else {
          bsInitSate.add(InitialStatus.onBoarding);
        }
      },
      loading: () {},
      error: (_, __) {},
    );
  }

  @override
  void dispose() {
    bsInitSate.close();
    super.dispose();
  }
}

enum InitialStatus { onBoarding, home, loading }
