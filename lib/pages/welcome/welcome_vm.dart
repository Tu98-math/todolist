import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '../../providers/auth_providers.dart';

class WelcomeViewModel extends BaseViewModel {
  BehaviorSubject<InitialState> bsInitSate =
      BehaviorSubject.seeded(InitialState.loading);

  WelcomeViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    final _authState = ref.watch(authStateProvider);
    _authState.when(
      data: (value) {
        if (value != null) {
          bsInitSate.add(InitialState.home);
        }
        bsInitSate.add(InitialState.onboarding);
      },
      loading: () {},
      error: (Object error, StackTrace? stackTrace) {},
    );
  }

  @override
  void dispose() {
    bsInitSate.close();
    super.dispose();
  }
}

enum InitialState { onboarding, home, loading }
