import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_list/constants/app_colors.dart';
import 'package:to_do_list/constants/images.dart';
import 'package:to_do_list/widgets/choose_color_icon.dart';
import 'package:to_do_list/widgets/sign_in_button.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({Key? key}) : super(key: key);

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
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
                          validator: (val) => val!.isNotEmpty
                            ? null
                            : 'Please enter your text',
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Enter your text ...",
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
                          press: () => {
                             if (_formKey.currentState!.validate() ) { 
                                FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("quick_note")
                                .add({
                                  'task': _descriptController.text.trim(),
                                  'color': indexChooseColor,
                                  'time': DateTime.now(),
                                  'list': false,
                                  'status': 0
                                }),
                                Navigator.pop(context)
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
}
