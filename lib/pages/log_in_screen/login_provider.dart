import 'package:riverpod/riverpod.dart';

import 'login_vm.dart';

final viewModelProvider = StateProvider.autoDispose<LoginViewModel>(
  (ref) {
    var vm = LoginViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
