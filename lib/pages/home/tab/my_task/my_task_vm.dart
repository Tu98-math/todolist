import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '/base/base_view_model.dart';

class MyTaskViewModel extends BaseViewModel {
  BehaviorSubject<bool> bsIsToDay = BehaviorSubject<bool>.seeded(true);

  MyTaskViewModel(AutoDisposeProviderReference ref) {
    init(ref);
  }

  void init(var ref) async {}

  setToDay(bool value) {
    bsIsToDay.add(value);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
