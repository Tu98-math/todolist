import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/util/extension/dimens.dart';
import 'package:to_do_list/util/extension/widget_extension.dart';
import 'package:to_do_list/widgets/choose_color_icon.dart';
import 'package:to_do_list/widgets/primary_button.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({Key? key, required this.press}) : super(key: key);

  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: AppColors.kColorNote[0],
      ),
      child: Center(
        child: Text(
          "+",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    )
        .inkTap(
          onTap: () => showAddProjectDialog(context),
          borderRadius: BorderRadius.circular(5.r),
        )
        .pad(20, 0, 12);
  }

  Future<void> showAddProjectDialog(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    int indexChooseColor = 0;
    final _formKey = GlobalKey<FormState>();
    TextEditingController _projectController = TextEditingController();
    return await showDialog(
      barrierColor: AppColors.kBarrierColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void _setColor(int index) {
            setState(() {
              indexChooseColor = index;
            });
          }

          return AlertDialog(
            contentPadding: EdgeInsets.all(24),
            content: Container(
              width: size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        color: AppColors.kText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      validator: (val) =>
                          val!.isNotEmpty ? null : 'Please enter your text',
                      controller: _projectController,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Choose Color",
                      style: TextStyle(
                        color: AppColors.kText,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (int i = 0; i < 5; i++)
                          ChooseColorIcon(
                            index: i,
                            press: _setColor,
                            tick: i == indexChooseColor,
                          ),
                      ],
                    ),
                    SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Done',
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          press(_projectController.text, indexChooseColor);
                          Get.back();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
