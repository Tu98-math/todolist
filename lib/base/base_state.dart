import 'package:flutter/material.dart';

import 'base_view_model.dart';

export 'package:easy_localization/easy_localization.dart';
export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:get/get.dart';

abstract class BaseState<T extends StatefulWidget, V extends BaseViewModel>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    getVm().bsLoading.distinct((a, b) => a == b).listen((show) {
      if (show) {
        showLoading();
      } else {
        closeLoading();
      }
    });
  }

  void showLoading() {}

  void closeLoading() {}

  V getVm();
}
