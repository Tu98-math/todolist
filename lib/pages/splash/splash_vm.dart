import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  SplashViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {}

  @override
  void dispose() {
    super.dispose();
  }
}