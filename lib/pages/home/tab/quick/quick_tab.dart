import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/models/quick_note_model.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '/widgets/quick_note_card.dart';
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
        color: Colors.white,
        height: screenHeight,
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.w),
              StreamBuilder<List<QuickNoteModel>>(
                  stream: getVm().streamQuickNote(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    List<QuickNoteModel> data = snapshot.data!;
                    print(data.length);
                    return Column(
                      children: [
                        for (int i = 0; i < data.length; i++)
                          QuickNoteCard(
                            note: data[i],
                            color: AppColors.kColorNote[data[i].indexColor],
                            deletePress: () =>
                                getVm().deleteQuickNote(data[i].id!),
                            checkedPress: getVm().checkedNote,
                          )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() => 'Quick Notes'
      .plainAppBar(color: AppColors.kText)
      .backgroundColor(Colors.white)
      .bAppBar();

  @override
  QuickViewModel getVm() => widget.watch(viewModelProvider).state;
}
