import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/base/base_state.dart';
import '/constants/app_colors.dart';
import '/constants/images.dart';
import '/models/quick_note_model.dart';
import '/pages/new_note/new_note_vm.dart';
import '/widgets/choose_color_icon.dart';
import '/widgets/sign_in_button.dart';
import 'new_note_provider.dart';

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
  TextEditingController _descriptController = TextEditingController();
  void _setColor(int index) {
    setState(() {
      indexChooseColor = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            width: size.width,
            height: 44,
            child: Container(color: AppColors.kPrimaryColor),
          ),
          Positioned(
            top: 10,
            left: 0,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextFormField(
                          controller: _descriptController,
                          validator: (val) =>
                              val!.isNotEmpty ? null : 'Please enter your text',
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your text ...",
                            hintStyle: TextStyle(
                              color: AppColors.kTextColor,
                            ),
                          ),
                          maxLines: 8,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Choose Color",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                        SignInButton(
                          text: "Done",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              QuickNoteModel quickNote = new QuickNoteModel(
                                  content: _descriptController.text,
                                  indexColor: indexChooseColor,
                                  id: '0',
                                  time: 0);
                              getVm().newNote(quickNote);
                              Navigator.pop(context);
                            }
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "New Note",
      ),
      automaticallyImplyLeading: false,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: SvgPicture.asset(
              AppImages.prevIcon,
              color: Colors.white,
            ), // Put icon of your preference.
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  @override
  NewNoteViewModel getVm() => widget.watch(viewModelProvider).state;
}
