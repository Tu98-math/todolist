import 'package:flutter/material.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/models/project_model.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '/util/ui/common_widget/add_project_button.dart';
import '/widgets/project_card.dart';
import 'menu_provider.dart';
import 'menu_vm.dart';

class MenuTab extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return MenuTab._(watch);
    });
  }

  const MenuTab._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return MenuState();
  }
}

class MenuState extends BaseState<MenuTab, MenuViewModel> {
  bool isToDay = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: StreamBuilder<List<ProjectModel>?>(
        stream: getVm().bsProject,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          List<ProjectModel> data = snapshot.data!;
          print(data.length);
          return Wrap(
            spacing: 12.w,
            runSpacing: 24.w,
            children: [
              SizedBox(
                height: 27.w,
                width: screenWidth,
              ),
              for (int i = 0; i < data.length; i++)
                ProjectCard(
                  project: data[i],
                  press: () {},
                ),
              AddProjectButton(
                press: getVm().addProject,
              )
            ],
          ).pad(0, 16);
        },
      ),
    );
  }

  AppBar buildAppBar() => 'Projects'
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  @override
  MenuViewModel getVm() => widget.watch(viewModelProvider).state;
}
