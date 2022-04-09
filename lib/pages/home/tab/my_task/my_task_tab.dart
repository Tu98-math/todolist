import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/app_colors.dart';

import '/base/base_state.dart';
import '/pages/home/tab/my_task/my_task_vm.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';
import 'my_task_provider.dart';
import 'widgets/filter_button.dart';
import 'widgets/to_day_switch.dart';

class MyTaskTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return MyTaskTab._(watch);
    });
  }

  const MyTaskTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return MyTaskState();
  }
}

class MyTaskState extends BaseState<MyTaskTab, MyTaskViewModel> {
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
      child: Column(
        children: [
          Container(
            color: AppColors.kPrimaryColor,
            height: 66,
            child: Column(
              children: [
                StreamBuilder<bool>(
                  stream: getVm().bsIsToDay,
                  builder: (context, snapshot) {
                    return ToDaySwitch(
                      isToDay: snapshot.data != null ? snapshot.data! : true,
                      press: getVm().setToDay,
                    );
                  },
                ),
              ],
            ),
          ),
          'LogOut'.desc().inkTap(onTap: () {
            getVm().signOut();
            Get.offAllNamed(AppRoutes.SIGN_IN);
          }),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.kPrimaryColor,
      title: 'Work List'
          .plain()
          .color(Colors.white)
          .weight(FontWeight.bold)
          .fSize(20)
          .b(),
      actions: [
        FilterButton(),
      ],
    );
  }

  @override
  MyTaskViewModel getVm() => widget.watch(viewModelProvider).state;
}
