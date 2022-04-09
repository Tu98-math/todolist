import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/models/note_model.dart';
import 'package:to_do_list/models/quick_note_model.dart';
import 'package:to_do_list/pages/new_check_list/new_check_list_vm.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:to_do_list/util/extension/widget_extension.dart';
import 'package:to_do_list/widgets/choose_color_icon.dart';
import 'package:to_do_list/widgets/primary_button.dart';

import '../../base/base_state.dart';
import '../auth/widgets/auth_text_field.dart';
import 'components/check_item.dart';
import 'new_check_list_provider.dart';

class NewCheckListPage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return NewCheckListPage._(watch);
    });
  }

  const NewCheckListPage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return NewCheckListState();
  }
}

class NewCheckListState
    extends BaseState<NewCheckListPage, NewCheckListViewModel> {
  int indexChooseColor = 0;
  int indexCheckItem = 4;
  void _setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
  }

  bool disable = true;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  List<TextEditingController> _listItemController = [
    for (int i = 0; i < 10; i++) TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: screenWidth,
            height: 44,
            child: Container(color: AppColors.kPrimaryColor),
          ),
          buildForm(),
        ],
      ),
    );
  }

  AppBar buildAppBar() => 'New Check List'.plainAppBar().bAppBar();

  Widget buildForm() => Positioned(
        top: 10.w,
        left: 0,
        width: screenWidth,
        child: Container(
          height: 700.w,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthTextField(
                      label: 'Title',
                      controller: _titleController,
                      hint: 'Enter your title ...',
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Please enter your text',
                      border: InputBorder.none,
                      maxLines: 2,
                    ),
                    for (int i = 0; i < indexCheckItem; i++)
                      CheckItem(
                        index: i,
                        controller: _listItemController[i],
                      ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '+Add new item'
                            .plain()
                            .fSize(16.w)
                            .lHeight(18.75)
                            .weight(FontWeight.w600)
                            .b()
                            .inkTap(
                          onTap: () {
                            setState(() {
                              if (indexCheckItem < 10) indexCheckItem++;
                            });
                          },
                        ),
                        'Remove item'
                            .plain()
                            .fSize(16.w)
                            .lHeight(18.75)
                            .weight(FontWeight.w600)
                            .b()
                            .inkTap(
                          onTap: () {
                            setState(() {
                              if (indexCheckItem > 1) indexCheckItem--;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    'Choose Color'
                        .plain()
                        .fSize(18)
                        .weight(FontWeight.w600)
                        .b(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 5; i++)
                          ChooseColorIcon(
                            index: i,
                            press: _setColor,
                            tick: i == indexChooseColor,
                          )
                      ],
                    ).pad(17, 0),
                    PrimaryButton(
                      text: "Done",
                      disable: disable,
                      press: () {
                        setState(() {
                          disable = false;
                        });
                        if (_formKey.currentState!.validate()) {
                          List<NoteModel> _list = [];
                          for (int i = 0; i < indexCheckItem; i++) {
                            _list.add(new NoteModel(
                                id: i,
                                text: _listItemController[i].text,
                                check: false));
                          }
                          getVm().newNote(
                            new QuickNoteModel(
                              content: _titleController.text,
                              indexColor: indexChooseColor,
                              time: DateTime.now(),
                              listNote: _list,
                            ),
                          );
                          setState(() {
                            disable = true;
                          });
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ).pad(0, 16),
          ),
        ),
      );

  @override
  NewCheckListViewModel getVm() => widget.watch(viewModelProvider).state;
}
