import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/app_colors.dart';

import '/base/base_state.dart';
import '/pages/home/tab/my_task/my_task_vm.dart';
import '/routing/app_routes.dart';
import '/util/extension/widget_extension.dart';
import '../../../../models/task_model.dart';
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
  void initState() {
    super.initState();
  }

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
            height: 300,
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
                StreamBuilder<List<TaskModel>>(
                  stream: getVm().bsListTask,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    List<TaskModel> data = snapshot.data!;
                    return Column(
                      children: [
                        for (int i = 0; i < data.length; i++)
                          data[i].title.desc(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          'LogOut'.desc().inkTap(onTap: () {
            getVm().signOut();
            Get.offAndToNamed(AppRoutes.SIGN_IN);
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
