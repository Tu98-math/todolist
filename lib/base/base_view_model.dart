import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:rxdart/rxdart.dart';

abstract class BaseViewModel {
  BehaviorSubject<bool> bsLoading = new BehaviorSubject.seeded(false);

  @mustCallSuper
  void dispose() {
    bsLoading.close();
  }

  showLoading() => bsLoading.add(true);

  closeLoading() => bsLoading.add(false);
}
