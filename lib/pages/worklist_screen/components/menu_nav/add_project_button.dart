import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/widgets/choose_color_icon.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';

class AddProjectButton extends StatelessWidget {
  const AddProjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 20,
      ),
      child: InkWell(
        onTap: () => showAddProjectDialog(context),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xFF6074F9),
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
        ),
      ),
    );
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
                        color: AppColors.kTextColor,
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
                        color: AppColors.kTextColor,
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
                    SignInButton(
                        text: 'Done',
                        press: () async {
                          int size = 0;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("project")
                              .get()
                              .then((snap) {
                            size = snap
                                .docs.length; // will return the collection size
                          });
                          if (_formKey.currentState!.validate()) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("project")
                                .doc('${size + 1}')
                                .set({
                              'title': _projectController.text.trim(),
                              'color': indexChooseColor,
                              'task': 0,
                              'id': '${size + 1}'
                            });
                            Navigator.pop(context);
                          }
                        }),
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
