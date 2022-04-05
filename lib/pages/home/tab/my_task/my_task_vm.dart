import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';
import '/providers/auth_provider.dart';

class MyTaskViewModel extends BaseViewModel {
  BehaviorSubject<bool> bsIsToDay = BehaviorSubject<bool>.seeded(true);
  dynamic auth;
  MyTaskViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {
    auth = ref.watch(authServicesProvider);
  }

  setToDay(bool value) {
    bsIsToDay.add(value);
  }

  void signOut() {
    auth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
