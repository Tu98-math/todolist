import 'package:riverpod/riverpod.dart';

import 'walk_through_vm.dart';

final viewModelProvider = StateProvider.autoDispose<WalkThroughViewModel>(
  (ref) {
    var vm = WalkThroughViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
