import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/models/quick_note_model.dart';
import '/pages/auth/widgets/auth_text_field.dart';
import '/util/extension/dimens.dart';
import '/util/extension/widget_extension.dart';
import '/widgets/choose_color_icon.dart';
import '/widgets/primary_button.dart';
import 'new_note_provider.dart';
import 'new_note_vm.dart';

class NewNotePage extends StatefulWidget {
  final ScopedReader watch;

  static Widget instance() {
    return Consumer(builder: (context, watch, _) {
      return NewNotePage._(watch);
    });
  }

  const NewNotePage._(this.watch);

  @override
  State<StatefulWidget> createState() {
    return NewNoteState();
  }
}

class NewNoteState extends BaseState<NewNotePage, NewNoteViewModel> {
  int indexChooseColor = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  void _setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
  }

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
            height: 44.w,
            child: Container(color: AppColors.kPrimaryColor),
          ),
          buildForm(),
        ],
      ),
    );
  }

  AppBar buildAppBar() => 'Add Note'.plainAppBar().bAppBar();

  Widget buildForm() => Positioned(
        top: 10,
        left: 0,
        width: screenWidth,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(
                    label: 'Description',
                    controller: descriptionController,
                    hint: 'Enter your note ...',
                    validator: (val) =>
                        val!.isNotEmpty ? null : 'Please enter your text',
                    border: InputBorder.none,
                    maxLines: 8,
                  ),
                  SizedBox(height: 10),
                  'Choose Color'
                      .plain()
                      .fSize(18)
                      .lHeight(22)
                      .weight(FontWeight.w600)
                      .b(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 5; i++)
                          ChooseColorIcon(
                            index: i,
                            press: _setColor,
                            tick: i == indexChooseColor,
                          )
                      ],
                    ),
                  ),
                  PrimaryButton(
                    text: "Done",
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        QuickNoteModel quickNote = new QuickNoteModel(
                          content: descriptionController.text,
                          indexColor: indexChooseColor,
                          time: DateTime.now(),
                        );
                        getVm().newNote(quickNote);
                        Get.back();
                      }
                    },
                  ),
                  SizedBox(height: 30.w),
                ],
              ),
            ),
          ),
        ).pad(0, 16),
      );

  @override
  NewNoteViewModel getVm() => widget.watch(viewModelProvider).state;
}
