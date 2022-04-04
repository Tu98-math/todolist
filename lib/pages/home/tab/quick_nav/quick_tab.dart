import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/util/extension/widget_extension.dart';
import 'quick_provider.dart';
import 'quick_vm.dart';

class QuickTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return QuickTab._(watch);
    });
  }

  const QuickTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return QuickState();
  }
}

class QuickState extends BaseState<QuickTab, QuickViewModel> {
  bool isToDay = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContainer(),
      appBar: buildAppBar(),
    );
  }

  Widget buildContainer() {
    return Container(
      child: Container(
        color: AppColors.kPrimaryColor,
        height: 60,
        child: Column(
          children: [],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: 'Quick Notes'
          .plain()
          .color(AppColors.kTextColor)
          .weight(FontWeight.bold)
          .fSize(20)
          .b(),
      actions: [],
    );
  }

  @override
  QuickViewModel getVm() => widget.watch(viewModelProvider).state;
}
