import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_view_model.dart';

class QuickViewModel extends BaseViewModel {
  QuickViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {}

  setToDay(bool value) {}

  @override
  void dispose() {
    super.dispose();
  }
}
